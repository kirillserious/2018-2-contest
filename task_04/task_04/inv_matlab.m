function invMat = inv_matlab(inpMat)
    % Проверка размерностей
    sz = size(inpMat);
    if sum(size(sz)~= [1, 2])||(sz(1)~=sz(2))||(abs(det(inpMat))<eps)
        invMat = NaN;
    
    % Все окей с размерностями
    else
        % Создали единичную матрицу
        n = sz(1);
        invMat = eye(n);
        % Прямой ход метода Гаусса
        for j = 1 : n
            a = inpMat(j, j);
            % Проверка на нулевой элемент
            if abs(a) < eps 
                m = find(inpMat(j:end, j), 1);
                % Перестановка строк
                for l=1:n
                    tmp = inpMat(m, l);
                    inpMat(m, l) = inpMat(j, l);
                    inpMat(j, l) = tmp;
                    tmp = invMat(m, l);
                    invMat(m, l) = invMat(j, l);
                    invMat(j, l) = tmp;
                end
                a = inpMat(j, j);
            end
            
            % Делим строку на главный элемент
            for l = 1 : j - 1
                invMat(j, l) = invMat(j, l)./ a;
            end
            invMat(j, j) = invMat(j, j) / a;
            inpMat(j, j)=1;
            
            for l = j + 1 : n
                invMat(j, l) = invMat(j, l)./ a;
                inpMat(j, l) = inpMat(j, l)./ a;
            end
            % Вычитаем строки
            for k = 1 : j - 1
                a1 =inpMat(k,j);
                if a1~=0
                    for l=1:j-1
                        invMat(k,l) = invMat(k,l) - invMat(j, l).*a1;
                    end
                    for l=j:n
                        inpMat(k,l) = inpMat(k,l) - inpMat(j, l).*a1;
                        invMat(k,l) = invMat(k,l) - invMat(j, l).*a1;
                    end
                end
            end
            
            % Обратный ход метода Гаусса
            for k = j + 1 : n
                a1 = inpMat(k,j);
                if a1~=0
                    for l=1:j-1
                        invMat(k,l) = invMat(k,l) - invMat(j, l).*a1;
                    end
                    for l=j:n
                        inpMat(k,l) = inpMat(k,l) - inpMat(j, l).*a1;
                        invMat(k,l) = invMat(k,l) - invMat(j, l).*a1;
                    end
                end
            end
            
        end
    end
end