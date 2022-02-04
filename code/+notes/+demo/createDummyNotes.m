function noteObjectArray = createDummyNotes(numSessions)

    if nargin < 1
        numSessions = 10;
    end

    noteObjectArray = notes.Note.empty;

    author = {'Eivind', 'Aree', 'Andreas'};
    validNoteTypes = {'Informal', 'Important', 'Todo', 'Question'};


    for i = 1:numSessions
        
        noteStruct = struct();
        noteStruct.ObjectType = 'session';
        uid = uuidgen();
        noteStruct.ObjectID = strcat('session-', uid(1:13));

        numNotes = randi(10);
        for j = 1:numNotes
        
            noteStruct.Author = author{randi(3)};
            noteStruct.Type = validNoteTypes{randi(4)};
            
            % Get lorem ipsumtext and split into title and text.
            text = matlab_ipsum('Paragraphs', 3, 'Sentences', 4);
            text = strsplit(text, '.');
                        
            noteStruct.Title = text{1};
            noteStruct.Text = strjoin(text(2:end), '.');
            
            % throw in some some hashtags
            idx = regexp(noteStruct.Text, ' ');
            idxTmp = idx(randperm(numel(idx), 3));
            noteStruct.Text(idxTmp+1) = '#';
            noteStruct.Tags = notes.Note.getTags(noteStruct.Text);

            % Set a random date...
            randTime = randi([2010, 2020]*365) + rand;
            noteStruct.DateTime = datetime(randTime, 'ConvertFrom', 'datenum');
            noteStruct.TimeStamp = char(noteStruct.DateTime);
            
            newNoteObj = notes.Note(noteStruct);
            noteObjectArray(end+1) = newNoteObj;
        end
        
    end

end