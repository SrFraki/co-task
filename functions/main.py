# Welcome to Cloud Functions for Firebase for Python!
# To get started, simply uncomment the below code or create your own.
# Deploy with `firebase deploy`

from firebase_functions import https_fn
from firebase_admin import db, initialize_app, auth
import flask
import jwt
import datetime

initialize_app()
app = flask.Flask(__name__)


@app.before_request
def verify_app_check() -> None:
    token = flask.request.args.get("auth", default="")
    decoded_token = ''
    try:
        decoded_token = auth.verify_id_token(token, check_revoked=True)
        uid = decoded_token['uid']
    except Exception as e:
        return f'ERROR> {e} \nTOKEN> {token} \nDECODED TOKEN> {decoded_token}'



@app.get("/")
def updateData(currentDate=None):
    dbDate = db.reference("last_week_mon").get()
    today = datetime.date.today()
    currentDate = (today - datetime.timedelta(days = today.weekday())).strftime("%Y-%m-%d")

    if currentDate == dbDate:
        task = db.reference("assigned_tasks").get()
        areCompleted = db.reference("completed_tasks").get()
        namesAndUids = db.reference("names_and_uid").get()
        return {
            'tasks': task,
            'areComplted': areCompleted,
            'names_and_uid': namesAndUids
        }  

    rotationalTasks = db.reference("rotational_tasks").get()
    rotationalTasks.insert(0, rotationalTasks.pop(len(rotationalTasks)-1))

    assignedTasks = db.reference("assigned_tasks").get()
    completedTasks = db.reference("completed_tasks").get()
    rotatedTasks = rotationalTasks.copy()

    for i, tasks in enumerate(completedTasks):
        if tasks:
            j = 0
            while j < len(tasks):
                if tasks[j] == '__null__':
                    j += 1
                    continue
                if tasks[j]:
                    completedTasks[i].pop(j)
                    assignedTasks[i].pop(j)
                else:
                    rotatedTasks[rotatedTasks.index(assignedTasks[i][j])] = None
                    j += 1


    if rotatedTasks and all(elem == None for elem in rotatedTasks):
        task = db.reference("assigned_tasks").get()[pos]
        areCompleted = db.reference("completed_tasks").get()[pos]
        return {
            'tasks': task,
            'areComplted': isCompleted
        }   

    for i, task in enumerate(rotatedTasks):
        if task is not None:
            assignedTasks[i].append(task)
            completedTasks[i].append(False)
            if '__null__' in assignedTasks[i]:
                 assignedTasks[i].remove('__null__')
                 completedTasks[i].remove('__null__')
        if len(assignedTasks[i]) == 0:
            assignedTasks[i].append('__null__')
            completedTasks[i].append('__null__')
    
    
    db.reference("/").update({
        'assigned_tasks': assignedTasks,
        'completed_tasks': completedTasks,
        'rotational_tasks': rotationalTasks,
        'last_week_mon': currentDate
    })
    
    namesAndUids = db.reference('names_and_uid').get()
    return {
        'tasks': assignedTasks,
        'areCompleted': completedTasks,
        'namesAndUids': namesAndUids
    }



@https_fn.on_request()
def getTasks(req: https_fn.Request) -> https_fn.Response:
    with app.request_context(req.environ):
        return app.full_dispatch_request()