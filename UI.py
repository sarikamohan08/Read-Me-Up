from tkinter import *
import mysql.connector

mydb=mysql.connector.connect(host="localhost",
     user="root",passwd="root",database="student")

def librarian():
     

     def add_student():
          root=Tk()
          def add_it():
               pop=Tk()
               data1=input11.get()
               data2=input12.get()
               data3=input13.get()
               data4=input14.get()
               data5=input15.get()
               data6=input16.get()
               data7=input17.get()
               
               cursor=mydb.cursor()
               cursor.execute("insert into student values(%s,%s,%s,%s,%s,%s,%s)",(data1,data2,data3,data4,data5,data6,data7))
               input11.delete(0,END)
               input12.delete(0,END)
               input13.delete(0,END)
               input14.delete(0,END)
               input15.delete(0,END)
               input16.delete(0,END)
               input17.delete(0,END)
               pop.title("added")
               label1=Label(pop,text="student added")
               label1.grid(row=0,column=5)
          
          root.title("Adding member")
          label11=Label(root,text="ADDING STUDENT")

          label12=Label(root,text="Student ID")
          label13=Label(root,text="Student Name")
          label14=Label(root,text="Department")
          label15=Label(root,text="batch")
          label16=Label(root,text="Issued books")
          label17=Label(root,text="Returned books")
          label18=Label(root,text="Fine amount")
          label11.grid(row=0,column=5)
          label12.grid(row=2,column=0)
          label13.grid(row=3,column=0)
          label14.grid(row=4,column=0)
          label15.grid(row=5,column=0)
          label16.grid(row=6,column=0)
          label17.grid(row=7,column=0)
          label18.grid(row=8,column=0)

          input11=StringVar()
          input12=StringVar()
          input13=StringVar()
          input14=StringVar()
          input15=StringVar()
          input16=StringVar()
          input17=StringVar()

          input11=Entry(root,borderwidth=5)
          input11.grid(row=2,column=1)
          input12=Entry(root,borderwidth=5)
          input12.grid(row=3,column=1)
          input13=Entry(root,borderwidth=5)
          input13.grid(row=4,column=1)
          input14=Entry(root,borderwidth=5)
          input14.grid(row=5,column=1)
          input15=Entry(root,borderwidth=5)
          input15.grid(row=6,column=1)
          input16=Entry(root,borderwidth=5)
          input16.grid(row=7,column=1)
          input17=Entry(root,borderwidth=5)
          input17.grid(row=8,column=1)


          button11=Button(root,text="ADD",width=10,command=add_it)
          button12=Button(root,text="LOG OUT",width=10,command=root.destroy)
          button11.grid(row=9,column=3)
          button12.grid(row=9,column=5)
          root.mainloop()
     def add_faculty():
          def add_it():
               pop=Tk()
               data1=input11.get()
               data2=input12.get()
               data3=input13.get()
               data4=input14.get()
               data5=input15.get()
          
               cursor=mydb.cursor()
               cursor.execute("insert into faculty values(%s,%s,%s,%s,%s)",(data1,data2,data3,data4,data5))
               input11.delete(0,END)
               input12.delete(0,END)
               input13.delete(0,END)
               input14.delete(0,END)
               input15.delete(0,END)
               pop.title("added")
               label1=Label(pop,text="faculty added")
               label1.grid(row=0,column=5)
               
          x=Tk()
          x.title("Adding faculty")
          label11=Label(x,text="ADDING faculty")

          label12=Label(x,text="faculty ID:")
          label13=Label(x,text="faculty Name;")
          label14=Label(x,text="Department:")
          label15=Label(x,text="books issued:")
          label16=Label(x,text="books returned:")
          label11.grid(row=0,column=5)
          label12.grid(row=2,column=0)
          label13.grid(row=3,column=0)
          label14.grid(row=4,column=0)
          label15.grid(row=5,column=0)
          label16.grid(row=6,column=0)
         
          input11=StringVar()
          input12=StringVar()
          input13=StringVar()
          input14=StringVar()
          input15=StringVar()
         

          input11=Entry(x,borderwidth=5)
          input11.grid(row=2,column=1)
          input12=Entry(x,borderwidth=5)
          input12.grid(row=3,column=1)
          input13=Entry(x,borderwidth=5)
          input13.grid(row=4,column=1)
          input14=Entry(x,borderwidth=5)
          input14.grid(row=5,column=1)
          input15=Entry(x,borderwidth=5)
          input15.grid(row=6,column=1)



          button11=Button(x,text="ADD",width=10,command=add_it)
          button12=Button(x,text="LOG OUT",width=10,command=x.destroy)
          button11.grid(row=9,column=3)
          button12.grid(row=9,column=5)
          x.mainloop()
     
     lib=Tk()
     cursor=mydb.cursor()
     cursor.execute("select * from librarian")
     records=cursor.fetchall()
     
     print_records=""
     a=[]
     for record in records:
          a.append(record)

     query_label1=Label(lib,text=a[0][0])
     query_label2=Label(lib,text=a[0][1])
    
     
     query_label1.grid(row=1,column=2)
     query_label2.grid(row=2,column=2)
     
     
     lib.geometry("400x400")
     lib.title("librarian")
     label1=Label(lib,text="LIBRARIAN")
     label1.grid(row=0,column=5)
     label2=Label(lib,text="Librarian ID:")
     label2.grid(row=1,column=0)
     label3=Label(lib,text="Librarian Name:")
     label3.grid(row=2,column=0)
     button1=Button(lib,text="add student",width=10,command=add_student)
     button1.grid(row=3,column=4)
     button2=Button(lib,text="add_faculty",width=10,command=add_faculty)
     button2.grid(row=3,column=5)
     button3=Button(lib,text="Exit",width=10,command=lib.destroy)
     button3.grid(row=3,column=6)
     
     
def faculty():
     
     
     window=Tk()
     cursor=mydb.cursor()
     cursor.execute("select * from faculty")
     records=cursor.fetchall()
     
     print_records=""
     a=[]
     for record in records:
          a.append(record)


          
     
     window.title("FACULTY INFO")

     query_label1=Label(window,text=a[0][0])
     query_label2=Label(window,text=a[0][1])
     query_label3=Label(window,text=a[0][2])
     query_label4=Label(window,text=a[0][3])
     query_label5=Label(window,text=a[0][4])
     
     
     query_label1.grid(row=9,column=1)
     query_label2.grid(row=10,column=1)
     query_label3.grid(row=11,column=1)
     query_label4.grid(row=12,column=1)
     query_label5.grid(row=13,column=1)
     
     
     l1=Label(window,text="FACULTY", font=("Times New Roman",25))
     window.geometry('600x600')
     l1.grid(column=1,row=0)

     name=Label(window,text="FACULTY_ID:").grid(row=9,column=0)

     contact=Label(window,text="NAME")
     contact.grid(row=10,column=0)
    

     name=Label(window,text="DEPARTMENT:").grid(row=11,column=0)
     

     l3=Label(window,text="BOOKS ISSUED:")
     l3.grid(column=0,row=12)
     
     l3=Label(window,text="BOOKS RETURNED;")
     l3.grid(column=0,row=13)
     
     btn = Button(window ,text="CLOSE",command=window.destroy).grid(row=15,column=2)

     window.mainloop()
          
def student():


          
     root=Tk()
     cursor=mydb.cursor()
     cursor.execute("select * from student")
     records=cursor.fetchall()
     
     print_records=""
     a=[]
     
     for record in records:
          a.append(record)
     
    
     query_label1=Label(root,text=a[0][0])
     query_label2=Label(root,text=a[0][1])
     query_label3=Label(root,text=a[0][2])
     query_label4=Label(root,text=a[0][3])
     query_label5=Label(root,text=a[0][4])
     query_label6=Label(root,text=a[0][5])
     query_label7=Label(root,text=a[0][6])
     query_label1.grid(row=2,column=1)
     query_label2.grid(row=3,column=1)
     query_label3.grid(row=4,column=1)
     query_label4.grid(row=5,column=1)
     query_label5.grid(row=6,column=1)
     query_label6.grid(row=7,column=1)
     query_label7.grid(row=8,column=1)
    
     
     root.title("STUDENT DETAILS")
     label11=Label(root,text="STUDENT DETAILS")

     label12=Label(root,text="Student ID:")
     label13=Label(root,text="Student Name:")
     label14=Label(root,text="Department:")
     label15=Label(root,text="batch:")
     label16=Label(root,text="Issued books:")
     label17=Label(root,text="Returned books:")
     label18=Label(root,text="Fine amount:")
     label11.grid(row=0,column=5)
     label12.grid(row=2,column=0)
     label13.grid(row=3,column=0)
     label14.grid(row=4,column=0)
     label15.grid(row=5,column=0)
     label16.grid(row=6,column=0)
     label17.grid(row=7,column=0)
     label18.grid(row=8,column=0)

     


     button12=Button(root,text="LOG OUT",width=10,command=root.destroy)
     button12.grid(row=9,column=5)
     root.mainloop()
     


b=Tk()
b.geometry("300x300")
b.title("welcome")
label1=Label(b,text="    ")
label1.grid(row=0,column=0)
label2=Label(b,text="WELCOME TO READ ME UP")
label2.grid(row=0,column=5)
button2=Button(b,text="STUDENT",width=10,command=student)
button2.grid(row=2,column=5)
button3=Button(b,text="FACULTY",width=10,command=faculty)
button3.grid(row=3,column=5)
button3=Button(b,text="LIBRARIAN",width=10,command=librarian)
button3.grid(row=4,column=5)
button4=Button(b,text="Exit",width=10,command=b.destroy)
button4.grid(row=5,column=5)
b.mainloop()


