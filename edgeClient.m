function y = edgeClient(cmd, qdata)
    global Log_Sig;
    global p;

    if cmd == "run tests" %run test on server's edge service
        load encData;
        load logsig;

        %initialization
        BitLength = 256; % should be a value of 2^N
        p = encServer(BitLength); % create an instance of PaillierCrypto class
        p.setFlintShifter(10000000);
        p.setPublicKey(pubKey);
        p.setPrivateKey(privKey);

        for k=1:size(logsig,2)
            t = p.doubleToFlint(logsig(k));
            Log_Sig(k) = p.encryptDouble(t);
        end
        
        for k=1:size(x,2)
            y(k)=PlaaServer(1,x(:,k));
        end
        plotconfusion(tTest,x);
        return;
    elseif cmd == "logsig" %calculate sigmoid and return to the server
        y = logsig_apply(qdata(:));
        return;
    end
end

function a = logsig_apply(n)
  for k=1:size(n,1)
    x = p.decrptDouble(n(k))
    a(k) = 1 ./ (1 + exp(-n));
  end
end

