function varargout = GUI(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1}) 
    
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end


function GUI_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;
guidata(hObject, handles);

function varargout = GUI_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


% Recibe el orden del sistema
function orden_Callback(hObject, eventdata, handles)
% Poner restriccion para que se permite solo numerico
N = str2double(get(hObject,'String'));
handles.orden = N;
guidata(hObject,handles);


function orden_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in aplicar.
function aplicar_Callback(hObject, eventdata, handles)
Ncolumns = handles.orden;
Nrows = handles.orden;

if Ncolumns < 2
    errordlg('El orden mínimo permitido es 2','Atención','modal')
else
    set(handles.valoresK,'Data',zeros(handles.orden))
    set(handles.valoresF,'Data',cell(Nrows,1))
    set(handles.obtenernorma,'Visible','on');
end


function MaxItr_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function MaxItr_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tolerancia_Callback(hObject, eventdata, handles)
Tolerancia = str2double(get(hObject,'String'));
if isnan(Tolerancia) || Tolerancia >= 1 || Tolerancia <= 0
    errordlg('Debes ingresar un valor numérico entre 0 y 1, como por ejemplo 0.0001','Bad Input','modal')
end
handles.Tolerancia = Tolerancia;
guidata(hObject,handles)




function tolerancia_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function salir_Callback(hObject, eventdata, handles)
delete(handles.figure1)


% --- Executes on button press in resolver.
function resolver_Callback(hObject, eventdata, handles)
    
    f = cell2mat(get(handles.valoresF,'Data'));
    k = get(handles.valoresK,'Data');
    
    MK = length(k);
    for i=1:MK
   
        for j=1:MK
        %validando tipo de datos
             if isnan(k(i,j))
                 errordlg('Ingresa un valor numérico','Bad Input','modal')
            end
        %Validando si es un número real
            esReal = isreal(k(i,j));
            if esReal == 0
                errordlg('Ingresa un valor real','Bad Input','modal');
            end
        end
    end

    MF = length(f);
    for i=1:MF
    %validando tipo de datos
         if isnan(f(i,1))
             errordlg('Ingresa un valor numérico','Bad Input','modal')
         end
    %Validando si es un número real
        esReal = isreal(f(i,1));
        if esReal == 0
            errordlg('Ingresa un valor real','Bad Input','modal');
        end
    end
    
    n = length(f);
    
    for i = 1:n
        j = 1:n;
        j(i) = [];
        C = abs(k(i,j));
        restaFila(i) = abs(k(i,i)) - sum(C); 
        if restaFila(i) < 0
            errordlg('La matriz no es diagonalmente dominante','Bad Input','modal');
            return
        end
    end
    
    Tolerancia = str2double(get(handles.tolerancia,'String'));
    switch get(get(handles.uibuttongroup1,'SelectedObject'),'Tag')
    case 'Jacobi'
        [tabla,error,iteraciones] = JACOBIANO(k,f,Tolerancia);
    otherwise
        [tabla,iteraciones,error] = GaussSeidel(k,f,Tolerancia);
    end
    
    set(handles.matrizK,'Data',tabla,'ColumnFormat',{'long'})
    set(handles.uitable7,'Data',error,'ColumnFormat',{'long'})
%     set(handles.unitable8,'Data',NOSD,'ColumnFormat',{'short'})



function valoresK_CellEditCallback(hObject, eventdata, handles)
set(handles.valoresK,'ColumnEditable',true(1,handles.orden))
%seteamos el formato de celdas
set(handles.valoresK,'ColumnFormat',{'Numeric'})

% --- Executes when entered data in editable cell(s) in valoresF.
function valoresF_CellEditCallback(hObject, eventdata, handles)
clc
set(handles.valoresF,'ColumnEditable',true(1,handles.orden))
%seteamos el formato de celdas
set(handles.valoresF,'ColumnFormat',{'Numeric'})
%obtenemos los valores ingresados en la tabla
f = cell2mat(get(handles.valoresF,'Data'));



function obtenernorma_Callback(hObject, eventdata, handles)
% verificar que sea una matriz correcta
k = get(handles.valoresK,'Data');

n1 = norm(k,1);
n2 = norm(k,2); 
ninf = norm(k,inf);

set(handles.norm1,'Visible','on');
set(handles.rtdonorm1, 'String', n1);
set(handles.rtdonorm1,'Visible','on');

set(handles.norm2,'Visible','on');
set(handles.rtdonorm2, 'String', n2);
set(handles.rtdonorm2,'Visible','on');

set(handles.norminf,'Visible','on');
set(handles.rtdonorminf, 'String', ninf);
set(handles.rtdonorminf,'Visible','on');


function rtdonorm1_Callback(hObject, eventdata, handles)
% hObject    handle to rtdonorm1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rtdonorm1 as text
%        str2double(get(hObject,'String')) returns contents of rtdonorm1 as a double


% --- Executes during object creation, after setting all properties.
function rtdonorm1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rtdonorm1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rtdonorm2_Callback(hObject, eventdata, handles)
% hObject    handle to rtdonorm2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rtdonorm2 as text
%        str2double(get(hObject,'String')) returns contents of rtdonorm2 as a double


% --- Executes during object creation, after setting all properties.
function rtdonorm2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rtdonorm2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rtdonorminf_Callback(hObject, eventdata, handles)
% hObject    handle to rtdonorminf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rtdonorminf as text
%        str2double(get(hObject,'String')) returns contents of rtdonorminf as a double


% --- Executes during object creation, after setting all properties.
function rtdonorminf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rtdonorminf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
