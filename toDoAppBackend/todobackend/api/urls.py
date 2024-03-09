from django.urls import path
from . import views

urlpatterns = [
    path('',views.getRoutes),
    path('notes/',views.getNotes),
    path('notes/create/',views.createNote),
    path('notes/<str:id>/update/',views.updateNote),
    path('notes/<str:id>/delete/',views.deleteNote),
    path('notes/<str:id>/',views.getNote)
]
