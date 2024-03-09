from rest_framework.decorators import api_view
from rest_framework.response import Response
from .serializers import NoteSerializer
from .models import Note

@api_view(['GET'])
def getRoutes(request) :
    
    routes = [
        {
            'Endpoint' : '/notes/',
            'method' : 'GET',
            'body' : None,
            'description' : 'Returns an array of notes'
        },
        {
            'Endpoint' : '/notes/id',
            'method' : 'GET',
            'body' : None,
            'description' : 'Returns a single note object'
        },
        {
            'Endpoint' : '/notes/create/',
            'method' : 'POST',
            'body' : {'body' : ""},
            'description' : 'Creates new note with data sent in post request'
        },
        {
            'Endpoint' : '/notes/id/update/',
            'method' : 'PUT',
            'body' : {'body' : ""},
            'description' : 'Creates an existing note with data sent in post request'
        },
        {
            'Endpoint' : '/notes/id/delete/',
            'method' : 'DELETE',
            'body' : None,
            'description' : 'Deletes an existing note'
        },
    ]
    
    return Response(routes)

@api_view(['GET'])
def getNotes(request) :
    notes = Note.objects.all()
    serializer = NoteSerializer(notes, many=True)
    return Response(serializer.data)

@api_view(['GET'])
def getNote(request, id) :
    note = Note.objects.get(id = id)
    serializer = NoteSerializer(note, many=False)
    return Response(serializer.data)
    
@api_view(['POST'])
def createNote(request) :    
    data = request.data
    note = Note.objects.create(
        title = data['title'],
        body = data['body']
    )
    
    serializer = NoteSerializer(note, many= False)
    
    return Response(serializer.data)


@api_view(['PUT'])
def updateNote(request,id) :    
    
    note = Note.objects.get(id = id)
    
    serializer = NoteSerializer(note, data=request.data)
    
    if serializer.is_valid() :
        serializer.save()
    
    return Response(serializer.data)

@api_view(['DELETE'])
def deleteNote(request,id) : 
    note = Note.objects.get(id = id)
    note.delete()
    return Response('Note was deleted!')
    
    
    