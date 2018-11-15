function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 12-Nov-2018 21:10:10

% Begin initialization code - DO NOT EDIT
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
% End initialization code - DO NOT EDIT


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% Recibe el orden del sistema
function orden_Callback(hObject, eventdata, handles)
% Poner restriccion para que se permite solo numerico
N = str2double(get(hObject,'String'));
handles.orden = N;
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function orden_CreateFcn(hObject, eventdata, handles)
% hObject    handle to orden (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in aplicar.
function aplicar_Callback(hObject, eventdata, handles)
Ncolumns = handles.orden;
%porque es 1.
Nrows = handles.orden;

%minimo 3?
if Ncolumns < 2
    errordlg('El orden mínimo permitido es 2','Atención','modal')
else
    %Ver las cantidad de columnas ( tienen que ser de igual orden?)
    set(handles.valoresK,'Data',zeros(handles.orden))
    set(handles.valoresF,'Data',cell(Nrows,1))
    %set(handles.valoresF,'Data',cell(Nrows,3))
end



%orden=get(handles.orden,'String');





function MaxItr_Callback(hObject, eventdata, handles)


% hObject    handle to MaxItr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MaxItr as text
%        str2double(get(hObject,'String')) returns contents of MaxItr as a double


% --- Executes during object creation, after setting all properties.
function MaxItr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MaxItr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
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

% hObject    handle to tolerancia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tolerancia as text
%        str2double(get(hObject,'String')) returns contents of tolerancia as a double


% --- Executes during object creation, after setting all properties.
function tolerancia_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tolerancia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in salir.
function salir_Callback(hObject, eventdata, handles)
delete(handles.figure1)

% hObject    handle to salir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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
        %Checkear que todos los valores no sean cero
             if mean(k(i,j)) == 0
                 errordlg('Todos los valores no deben ser 0','Bad Input','modal');
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

    Tolerancia = handles.Tolerancia;
%   NInicial = 15; %Numero inicial de iteraciones
    
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

    [tabla,iteraciones,error] = GaussSeidel(k,f,Tolerancia);
    b = VectorB(f,tabla);
    
    set(handles.matrizK,'Data',tabla,'ColumnFormat',{'long'})
%     set(handles.unitable4,'Data',x,'ColumnFormat',{'long'})
%     set(handles.unitable5,'Data',b,'ColumnFormat',{'short'})
%     set(handles.unitable6,'Data',Xe,'ColumnFormat',{'long'})
    set(handles.uitable7,'Data',error,'ColumnFormat',{'long'})
%     set(handles.unitable8,'Data',NOSD,'ColumnFormat',{'short'})


% --- Executes when entered data in editable cell(s) in valoresK.
function valoresK_CellEditCallback(hObject, eventdata, handles)
set(handles.valoresK,'ColumnEditable',true(1,handles.orden))
%seteamos el formato de celdas
set(handles.valoresK,'ColumnFormat',{'Numeric'})
%obtenemos los valores ingresados en la tabla


% k = cell2mat(get(handles.valoresK,'Data'));
% 
%     handles.k = k;
%     guidata(hObject,handles)


% hObject    handle to valoresK (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when entered data in editable cell(s) in valoresF.
function valoresF_CellEditCallback(hObject, eventdata, handles)
clc
set(handles.valoresF,'ColumnEditable',true(1,handles.orden))
%seteamos el formato de celdas
set(handles.valoresF,'ColumnFormat',{'Numeric'})
%obtenemos los valores ingresados en la tabla
f = cell2mat(get(handles.valoresF,'Data'));


% hObject    handle to valoresF (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
