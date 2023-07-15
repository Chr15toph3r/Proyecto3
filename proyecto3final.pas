program Proyecto3;
uses crt, sysUtils;

type
    MenuOption = (NewCustomer, ViewCustomers, ClearCustomersDataOption, GoBack);
    CustomerTypeOption = (Individual, Accompanied, GroupFamily, CustomerTypeBack);
    RoomType = (FamilyRoom, SingleRoom, DoubleRoom, SuiteRoom);

    Child = record
        firstName: string;
        lastName: string;
        age: integer;
    end;        

    Customer = record
        firstName: string;
        lastName: string;
        idNumber: string;
        email: string;
        phoneNumber: string;
        stayDuration: LongInt;
        roomType: RoomType;
        totalPayment: real;
        numChildren: integer;
        children: array [1..10] of Child;
    end;

    CustomerFile = file of Customer;

const
    FamilyRoomPrice = 200;
    SingleRoomPrice = 60;
    DoubleRoomPrice = 120;
    SuiteRoomPrice = 300;

var
    currentOption: MenuOption;
    currentCustomerTypeOption: CustomerTypeOption;
    key: char;
    currentCustomer: Customer;
    individualCustomersData: CustomerFile;
    accompaniedCustomersData: CustomerFile;
    groupFamilyCustomersData: CustomerFile;
    allCustomersData: CustomerFile;
    selectedRoomType: RoomType;
    times: LongInt;
    inputStr: string;

procedure ShowMenu;
begin
    ClrScr;
    writeln('-------- Hotel Lidotel Boutique Margarita -------');
    writeln;
    writeln('Seleccione una opcion:');
    writeln('1. Nuevo Cliente');
    writeln('2. Ver Clientes Registrados');
    writeln('3. Limpiar Datos de Clientes');
    writeln('4. Volver');
    writeln;
    writeln('-------------------------------------------------');
end;

procedure ShowRoomDescriptions;
begin

    writeln('-------------------------------------------------');
    writeln('Descripción de las habitaciones:');
    writeln;
    writeln('FAMILY ROOM  200$ por noche');
    writeln('- Habitación cálida y confortable');
    writeln('- Cama Lidotel Royal King y 2 camas full en una habitación separada');
    writeln('- Baño con ducha');
    writeln('- Cafetera eléctrica, nevera ejecutiva y caja electrónica de seguridad');
    writeln('- Incluye desayuno buffet, acceso a internet, piscina, gimnasio y kit de vanidades');
    writeln;
    writeln('SENCILLA  60$ por noche');
    writeln('- Habitación amplia y confortable');
    writeln('- Cama Lidotel Royal King');
    writeln('- Baño con ducha');
    writeln('- Cafetera eléctrica, nevera ejecutiva y caja electrónica de seguridad');
    writeln('- Incluye desayuno buffet, acceso a internet, piscina, gimnasio y kit de vanidades');
    writeln;
    writeln('DOBLE  120$ por noche');
    writeln('- Habitación amplia y confortable');
    writeln('- Dos camas Lidotel Full');
    writeln('- Baño con ducha');
    writeln('- Cafetera eléctrica, nevera ejecutiva y caja electrónica de seguridad');
    writeln('- Incluye desayuno buffet, acceso a internet, piscina, gimnasio y kit de vanidades');
    writeln;
    writeln('SUITE  300$ por noche');
    writeln('- Habitación cálida y confortable');
    writeln('- Cama Lidotel Royal King y área separada con 2 sofá-cama individuales');
    writeln('- 2 baños con ducha');
    writeln('- Cafetera eléctrica, nevera ejecutiva y caja electrónica de seguridad');
    writeln('- Incluye desayuno buffet, acceso a internet, piscina, gimnasio y kit de vanidades');
    writeln; WriteLn;
end;

procedure ShowCustomerTypeMenu;
begin
    ClrScr;
    writeln('-------- Seleccione el Tipo de Cliente ----------');
    writeln;
    writeln('1. Individual');
    writeln('2. Pareja');
    writeln('3. Familia');
    writeln('4. Volver');
    writeln;
    writeln('-------------------------------------------------');
end;

function GetRoomPrice(roomType: RoomType): real;
begin
    case roomType of
        FamilyRoom: GetRoomPrice := FamilyRoomPrice;
        SingleRoom: GetRoomPrice := SingleRoomPrice;
        DoubleRoom: GetRoomPrice := DoubleRoomPrice;
        SuiteRoom: GetRoomPrice := SuiteRoomPrice;
    end;
end;

procedure InputCustomerData(var customerData: CustomerFile; times: integer; roomType: RoomType; var allCustomersData: CustomerFile);
var
    i: integer;
begin
    for i := 1 to times do
    begin
        ClrScr;
        writeln('-------- Registro del Cliente #', i, ' --------');
        writeln;

        Assign(customerData, 'individualCustomers.dat');
        Assign(allCustomersData, 'allCustomers.dat');

        if not FileExists('individualCustomers.dat') then
            Rewrite(customerData)
        else
            Reset(customerData);

        if not FileExists('allCustomers.dat') then
            Rewrite(allCustomersData)
        else
            Reset(allCustomersData);

        Seek(customerData, FileSize(customerData));
        Seek(allCustomersData, FileSize(allCustomersData));

writeln('Ingrese los datos del cliente:');
writeln('Nombre: ');
repeat
    readln(currentCustomer.firstName);
    if currentCustomer.firstName = '' then
    begin
        writeln('El nombre no puede estar vacio. Introduce un valor valido: ');
    end;
until currentCustomer.firstName <> '';

writeln('Apellido: ');
repeat
    readln(currentCustomer.lastName);
    if currentCustomer.lastName = '' then
    begin
        writeln('El apellido no puede estar vacio. Introduce un valor valido: ');
    end;
until currentCustomer.lastName <> '';

writeln('Numero de cedula: ');
repeat
    readln(currentCustomer.idNumber);
    if currentCustomer.idNumber = '' then
    begin
        writeln('El numero de cédula no puede estar vacio. Introduce un valor valido: ');
    end;
until currentCustomer.idNumber <> '';

writeln('Email: ');
repeat
    readln(currentCustomer.email);
    if currentCustomer.email = '' then
    begin
        writeln('El email no puede estar vacio. Introduce un valor valido: ');
    end;
until currentCustomer.email <> '';

writeln('Numero de telefono: ');
repeat
    readln(currentCustomer.phoneNumber);
    if currentCustomer.phoneNumber = '' then
    begin
        writeln('El numero de teléfono no puede estar vacio. Introduce un valor valido: ');
    end;
until currentCustomer.phoneNumber <> '';

writeln('Cantidad de días de estadia: ');
repeat
    readln(inputStr);
    if not TryStrToInt(inputStr, currentCustomer.stayDuration) then
    begin
        writeln('Entrada inválida. Introduce un numero entero valido: ');
    end;
until TryStrToInt(inputStr, currentCustomer.stayDuration);

        currentCustomer.roomType := roomType;
        currentCustomer.totalPayment := GetRoomPrice(roomType) * currentCustomer.stayDuration;

        write(customerData, currentCustomer);
        write(allCustomersData, currentCustomer);

        Close(customerData);
        Close(allCustomersData);

        writeln;
        writeln('Registro de cliente exitoso.');
        writeln('Presione cualquier tecla para continuar...');
        readln;
    end;
end;

procedure InputCoupleData(var customerData: CustomerFile; var allCustomersData: CustomerFile);
begin
    ClrScr;
    writeln('-------- Registro de Pareja --------');
    writeln;

    Assign(customerData, 'accompaniedCustomers.dat');
    Assign(allCustomersData, 'allCustomers.dat');

    if not FileExists('accompaniedCustomers.dat') then
        Rewrite(customerData)
    else
        Reset(customerData);

    if not FileExists('allCustomers.dat') then
        Rewrite(allCustomersData)
    else
        Reset(allCustomersData);

    Seek(customerData, FileSize(customerData));
    Seek(allCustomersData, FileSize(allCustomersData));

    writeln('Ingrese los datos del cliente 1:');
    writeln('Nombre: '); readln(currentCustomer.firstName);
    writeln('Apellido: '); readln(currentCustomer.lastName);
    writeln('Numero de cedula: '); readln(currentCustomer.idNumber);
    writeln('Email: '); readln(currentCustomer.email);
    writeln('Numero de telefono: '); readln(currentCustomer.phoneNumber);
    writeln('Cantidad de días de estadia: '); readln(currentCustomer.stayDuration);

    writeln('Seleccione el tipo de habitacion:');
    writeln('1. Habitacion Familiar - 200$ por noche.');
    writeln('2. Habitacion Individual - 60$ por noche.');
    writeln('3. Habitacion Doble - 120$ por noche.');
    writeln('4. Suite - 300$ por noche.');
    write('Opcion: '); readln(key);

    case key of
        '1': selectedRoomType := FamilyRoom;
        '2': selectedRoomType := SingleRoom;
        '3': selectedRoomType := DoubleRoom;
        '4': selectedRoomType := SuiteRoom;
    end;

    currentCustomer.roomType := selectedRoomType;
    currentCustomer.totalPayment := GetRoomPrice(selectedRoomType) * currentCustomer.stayDuration;

    write(customerData, currentCustomer);
    write(allCustomersData, currentCustomer);

    writeln;

    writeln('Ingrese los datos del cliente 2:');
    writeln('Nombre: '); readln(currentCustomer.firstName);
    writeln('Apellido: '); readln(currentCustomer.lastName);
    writeln('Numero de cedula: '); readln(currentCustomer.idNumber);
    writeln('Email: '); readln(currentCustomer.email);
    writeln('Numero de telefono: '); readln(currentCustomer.phoneNumber);
    writeln('Cantidad de días de estadía: '); readln(currentCustomer.stayDuration);

    currentCustomer.roomType := selectedRoomType;
    currentCustomer.totalPayment := GetRoomPrice(selectedRoomType) * currentCustomer.stayDuration;

    write(customerData, currentCustomer);
    write(allCustomersData, currentCustomer);

    Close(customerData);
    Close(allCustomersData);

    writeln;
    writeln('Registro de pareja exitoso.');
    writeln('Presione cualquier tecla para continuar...');
    readln;
end;

procedure InputFamilyData(var customerData: CustomerFile; var allCustomersData: CustomerFile);
var
    i, j: integer;
    numAdults, numChildren: integer;
begin
    ClrScr;
    writeln('-------- Registro de Familia/Grupo --------');
    writeln;

    Assign(customerData, 'groupFamilyCustomers.dat');
    Assign(allCustomersData, 'allCustomers.dat');

    if not FileExists('groupFamilyCustomers.dat') then
        Rewrite(customerData)
    else
        Reset(customerData);

    if not FileExists('allCustomers.dat') then
        Rewrite(allCustomersData)
    else
        Reset(allCustomersData);

    Seek(customerData, FileSize(customerData));
    Seek(allCustomersData, FileSize(allCustomersData));

    writeln('Ingrese la cantidad de adultos: '); readln(numAdults);
    writeln('Ingrese la cantidad de niños: '); readln(numChildren);
    writeln;

    writeln('Seleccione el tipo de habitacion:');
    writeln('1. Habitacion Familiar - 200$ por noche.');
    writeln('2. Habitacion Individual - 60$ por noche.');
    writeln('3. Habitacion Doble - 120$ por noche.');
    writeln('4. Suite - 300$ por noche.');
    write('Opcion: '); readln(key);

    case key of
        '1': selectedRoomType := FamilyRoom;
        '2': selectedRoomType := SingleRoom;
        '3': selectedRoomType := DoubleRoom;
        '4': selectedRoomType := SuiteRoom;
    end;

    for i := 1 to numAdults do
    begin
        writeln('Ingrese los datos del adulto #', i, ':');
        writeln('Nombre: '); readln(currentCustomer.firstName);
        writeln('Apellido: '); readln(currentCustomer.lastName);
        writeln('Numero de cedula: '); readln(currentCustomer.idNumber);
        writeln('Email: '); readln(currentCustomer.email);
        writeln('Numero de telefono: '); readln(currentCustomer.phoneNumber);
        writeln('Cantidad de dias de estadia: '); readln(currentCustomer.stayDuration);

        currentCustomer.roomType := selectedRoomType;
        currentCustomer.totalPayment := GetRoomPrice(selectedRoomType) * currentCustomer.stayDuration;
        currentCustomer.numChildren := numChildren;

        for j := 1 to numChildren do
        begin
            writeln('Ingrese los datos del niño #', j, ':');
            writeln('Nombre: '); readln(currentCustomer.children[j].firstName);
            writeln('Apellido: '); readln(currentCustomer.children[j].lastName);
            writeln('Edad: '); readln(currentCustomer.children[j].age);
        end;

        write(customerData, currentCustomer);
        write(allCustomersData, currentCustomer);

        writeln;
        writeln('Registro de adulto #', i, ' exitoso.');
        writeln;
    end;

    Close(customerData);
    Close(allCustomersData);

    writeln('Registro de familia/grupo exitoso.');
    writeln('Presione cualquier tecla para continuar...');
    readln;
end;

procedure ViewCustomerData(var customerData: CustomerFile; customerType: string);
var
    i, j: integer;
begin
    ClrScr;
    writeln('-------- ', customerType, ' Customers -------');
    writeln;

    Assign(customerData, customerType + 'Customers.dat');
    if not FileExists(customerType + 'Customers.dat') then
    begin
        writeln('No existen registros de este tipo de clientes.');
        writeln('Presione cualquier tecla para continuar...');
        readln;
        exit;
    end;

    Reset(customerData);
    i := 0;
    while not Eof(customerData) do
    begin
        i := i + 1;
        read(customerData, currentCustomer);

        writeln('Cliente #', i, ':');
        writeln('Nombre: ', currentCustomer.firstName);
        writeln('Apellido: ', currentCustomer.lastName);
        writeln('Numero de cedula: ', currentCustomer.idNumber);
        writeln('Email: ', currentCustomer.email);
        writeln('Numero de telefono: ', currentCustomer.phoneNumber);
        writeln('Cantidad de días de estadía: ', currentCustomer.stayDuration);
        writeln('Tipo de habitacion: ', Ord(currentCustomer.roomType) + 1);
        writeln('Pago total: ', currentCustomer.totalPayment:4:2);
        if currentCustomer.numChildren > 0 then
        begin
            writeln('Niños: ');
            for j := 1 to currentCustomer.numChildren do
            begin
                writeln('  Niño #', j, ':');
                writeln('  Nombre: ', currentCustomer.children[j].firstName);
                writeln('  Apellido: ', currentCustomer.children[j].lastName);
                writeln('  Edad: ', currentCustomer.children[j].age);
            end;
        end;
        writeln;
    end;
    writeln('Presione cualquier tecla para continuar...');
    readln;
    Close(customerData);
end;

procedure ClearCustomersData(var customerData: CustomerFile; customerType: string);
begin
    ClrScr;
    writeln('-------- Limpiar Datos de ', customerType, ' --------');
    writeln;

    Assign(customerData, customerType + 'Customers.dat');
    if not FileExists(customerType + 'Customers.dat') then
    begin
        writeln('No existen registros de este tipo de clientes.');
        writeln('Presione cualquier tecla para continuar...');
        readln;
        exit;
    end;

    Erase(customerData);
    writeln('Datos de ', customerType, ' limpiados exitosamente.');
    writeln('Presione cualquier tecla para continuar...');
    readln;
end;
begin
  ClrScr;
  GotoXY(10, 10);
  WriteLn('HOTEL LIDOTEL BOUTIQUE MARGARITA');
  GotoXY(10, 11);
  TextColor(Yellow);
  WriteLn('==========                       ');
  GotoXY(20, 11);
  TextColor(LightBlue);
  WriteLn('=============');
  GotoXY(33, 11);
  TextColor(LightRed);
  WriteLn('=========');
  ReadLn;
repeat
  TextColor(White);
  ShowMenu;
  write('Opcion: '); 
  readln(key);

  case key of
    '1': begin
      repeat
        ShowCustomerTypeMenu;
        write('Opcion: '); 
        readln(key);

        case key of
          '1': begin
            ClrScr;
            writeln('-------- Registro de Cliente Individual --------');
            writeln;
            writeln('Ingrese la cantidad de clientes a registrar: ');

            repeat
              readln(inputStr);
              if (inputStr = '') or (not TryStrToInt(inputStr, times)) or (times <= 0) then
              begin
                writeln('Entrada inválida. Introduce un numero entero valido mayor a cero: ');
              end;
            until (inputStr <> '') and (TryStrToInt(inputStr, times)) and (times > 0);

            ShowRoomDescriptions;
            writeln('Seleccione el tipo de habitacion:');
            writeln('1. Habitacion Familiar - 200$ por noche.');
            writeln('2. Habitacion Individual - 60$ por noche.');
            writeln('3. Habitacion Doble - 120$ por noche.');
            writeln('4. Suite - 300$ por noche.');

            repeat
              write('Opcion: ');
              readln(key);
              if not (key in ['1', '2', '3', '4']) then
              begin
                writeln('Entrada inválida. Introduce una opción válida (1, 2, 3, 4): ');
              end;
            until key in ['1', '2', '3', '4'];

            case key of
              '1': selectedRoomType := FamilyRoom;
              '2': selectedRoomType := SingleRoom;
              '3': selectedRoomType := DoubleRoom;
              '4': selectedRoomType := SuiteRoom;
            end;

            InputCustomerData(individualCustomersData, times, selectedRoomType, allCustomersData);
            currentCustomerTypeOption := CustomerTypeBack;
          end;
          '2': begin
            InputCoupleData(accompaniedCustomersData, allCustomersData);
            currentCustomerTypeOption := CustomerTypeBack;
          end;
          '3': begin
            InputFamilyData(groupFamilyCustomersData, allCustomersData);
            currentCustomerTypeOption := CustomerTypeBack;
          end;
          '4': currentCustomerTypeOption := CustomerTypeBack;
        end;
      until currentCustomerTypeOption = CustomerTypeBack;
      currentOption := GoBack;
    end;
    '2': begin
      ClrScr;
      writeln('-------- Ver Clientes Registrados --------');
      writeln;
      writeln('Seleccione el tipo de cliente a visualizar:');
      writeln('1. Individual');
      writeln('2. Pareja');
      writeln('3. Familia');
      writeln('4. Todos');
      writeln('5. Volver');
      writeln;
      write('Opcion: '); 
      readln(key);

      case key of
        '1': ViewCustomerData(individualCustomersData, 'individual');
        '2': ViewCustomerData(accompaniedCustomersData, 'accompanied');
        '3': ViewCustomerData(groupFamilyCustomersData, 'groupFamily');
        '4': ViewCustomerData(allCustomersData, 'all');
        '5': currentOption := GoBack;
      end;
    end;
    '3': begin
      ClrScr;
      writeln('-------- Limpiar Datos de Clientes --------');
      writeln;
      writeln('Seleccione el tipo de cliente cuyos datos desea limpiar:');
      writeln('1. Individual');
      writeln('2. Pareja');
      writeln('3. Familia');
      writeln('4. Todos');
      writeln('5. Volver');
      writeln;
      write('Opcion: '); 
      readln(key);

      case key of
        '1': ClearCustomersData(individualCustomersData, 'individual');
        '2': ClearCustomersData(accompaniedCustomersData, 'accompanied');
        '3': ClearCustomersData(groupFamilyCustomersData, 'groupFamily');
        '4': begin
          ClearCustomersData(individualCustomersData, 'individual');
          ClearCustomersData(accompaniedCustomersData, 'accompanied');
          ClearCustomersData(groupFamilyCustomersData, 'groupFamily');
          ClearCustomersData(allCustomersData, 'all');
        end;
        '5': currentOption := GoBack;
      end;
    end;
    '4': currentOption := GoBack;
  end;
until currentOption = GoBack;
end.