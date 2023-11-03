/*
 *********
 * JUDGE *
 *********
 * Order, order in the room please.
 * Good Morning, ladies and gentlemen. Calling the case of the People of the 
 * State of Esolangs versus Database Admin. Are both sides ready?
 */

/*
 *********************
 * DISTRICT ATTORNEY *
 *********************
 * Ready for the People, Your Honour.
 */

/*
 *******************
 * PUBLIC DEFENDER *
 *******************
 * Ready for the defense, Your Honour.
 */

/*
 *********
 * JUDGE *
 *********
 * Will the clerk please swear in the jury?
 */

/*
 *********
 * CLERK *
 *********
 * Will the jury please stand and raise your right hand? [Wait for
 * everyone to stand.] Do each of you swear that you will fairly try the
 * case before this court, and that you will return a true verdict according to
 * the evidence and the instructions of the court, so help you, God? Please
 * say “I do”. [Wait for jurors to say “I do.”] You may be seated.
 */

/*
 *********************
 * DISTRICT ATTORNEY *
 *********************
 * Your Honor and ladies and gentlemen of the jury: the defendant has been
 * charged with the act of the segregation of candidate keys from their natural
 * habitat. The evidence will show that a group of table keys were racially
 * profiled on the night of October 22nd. The next day the defendant was
 * arrested teaching the rules of apartheid segregation to the "superior" and
 * "unique" keys on October 29th. The evidence I will present to you will prove
 * that the defendant is guilty as charged.
 */

/*
 *******************
 * PUBLIC DEFENDER *
 *******************
 * Your Honor and ladies and gentlemen of the jury: under the law my client is
 * presumed innocent until proved guilty. During this trial, you will hear no
 * real evidence against my client. You will come to know the truth: that my
 * client was just performing the duties of his paid job with no ulterior
 * motives.
 * Therfore my client is not guilty.
 */
let hearing = (table) => {
        /*
         *********
         * JUDGE *
         *********
         * The prosecution may call its first witness.
         */

        /*
         *********************
         * DISTRICT ATTORNEY *
         *********************
         * The people call the Back End of the table.
         */

        /*
         *********
         * CLERK *
         *********
         * Please stand. Raise your right hand. Do you promise that the
         * testimony you shall give in the case before this court shall be the truth,
         * the whole truth, and nothing but the truth, so help you God?
         */

        /*
         *********************
         * DISTRICT ATTORNEY *
         *********************
         * The people call the Back End of the table.
         */

        /*
         ************
         * BACK END *
         ************
         * I do.
         */
        
        /*
         *********
         * CLERK *
         *********
         * Please state your first and last name.
         */
        
        /*
         ************
         * BACK END *
         ************
         * Relationah Aljabrah.
         */
        
        /*
         *********
         * CLERK *
         *********
         * You may be seated.
         */
        
        /*
         *********************
         * DISTRICT ATTORNEY *
         *********************
         * Please state the details of the crime as you saw it on the 22nd of October.
         */
        
        /*
         ************
         * BACK END *
         ************
         * i was out there mindin my own business when i noticed half my friends
         * was missin!
         */

        /*
         *********************
         * DISTRICT ATTORNEY *
         *********************
         * From this anecdote, we can conclude that the defendant was performing
         * an obstruction to the task of the BACK END worker, who was also 
         * a witness to the crime.
         */
        
        /*
         *********************
         * DISTRICT ATTORNEY *
         *********************
         * As the record may be seen in paragraph 5, your honour, there is a 
         * stark "special casing" requirement in the code for the current hearing.
         * This has been addressed in the below transcript.
         */
        if (table.length <= 2) {
                return [[]];
        }
        /*
         *********************
         * DISTRICT ATTORNEY *
         *********************
         * As the jury may be able to see, this "candidate key extraction"
         * was a premeditated crime. The perpetrators of the crime had their
         * target columns decided many lines before the time of return.
         */
        let col_names = table[0];
        let table_rows = table.slice(1);
        let candidate_keys = (col_indices, rows) => {
                /*
                 *******************
                 * PUBLIC DEFENDER *
                 *******************
                 * The given claims from the People, your honour, are false,
                 * as my client has an alibi during the time of crime.
                 * The number of columns for the table was also a stark
                 * "special case", preventing such a selection from happening!
                 */
                if (col_indices.length > 1) {
                        let result_keys = [];

                        for(let i = 0; i < col_indices.length; i++) {
                                let recur_col_indices = col_indices.slice();
                                recur_col_indices.splice(i,1);
                                /*
                                 *********
                                 * JUDGE *
                                 *********
                                 * The jury is thanked and excused for the session.
                                 * Court is adjourned, as we lack the stack frames to continue. 
                                 */
                                let result_iter = candidate_keys(recur_col_indices, rows);
                                for (let j = 0; j < result_iter.length; j++) {
                                        result_keys.push(result_iter[j]);
                                }
                        }
                        if (result_keys.length > 0) {
                                return result_keys;
                        }
                }
                let selected_rows = [];
                for (let i = 0; i < rows.length; i++) {
                        let curr_row = [];
                        for (let j = 0; j < col_indices.length; j++) {
                                curr_row.push(rows[i][col_indices[j]]);
                        }
                        selected_rows.push(curr_row);
                }
                for (let i = 0; i < selected_rows.length; i++) {
                        for (let j = 0; j < selected_rows.length; j++) {
                                if (i != j) {
                                        if (selected_rows[i].length == selected_rows[j].length) {
                                                let is_equal = true;
                                                for(let k = 0; k < selected_rows[i].length; k++) {
                                                        if (selected_rows[i][k] != selected_rows[j][k]) {
                                                                is_equal = false;
                                                                break;
                                                        }
                                                }
                                                if (is_equal) {
                                                        
                                                        return [];
                                                }
                                        }
                                }
                        }
                }
                return [col_indices];
        }
        let range = [];
        for (let i = 0; i < table_rows[0].length; i++) {
                range.push(i);
        }
        let candidate_key_indices =  candidate_keys(range, table_rows);
        let unique_candidate_keys = [];
        for (let i = 0; i < candidate_key_indices.length; i++) {
                let isnt_added = true;
                for(let j = 0; j < unique_candidate_keys.length; j++) { 
                        let is_equal = true;
                        if (candidate_key_indices[i].length == unique_candidate_keys[j].length) {
                                for (let k = 0; k < candidate_key_indices.length; k++) {
                                        if (candidate_key_indices[i][k] != unique_candidate_keys[j][k]) {
                                                is_equal = false;
                                                break;
                                        }
                                }
                        } else {
                                is_equal = false;
                        }
                        if (is_equal) {
                                isnt_added = false;
                                break;
                        }
                }
                if (isnt_added) {
                        unique_candidate_keys.push(candidate_key_indices[i]);
                }
        }
        for (let i = 0; i < unique_candidate_keys.length; i++) {
                for (let j = 0; j < unique_candidate_keys[i].length; j++) {
                        unique_candidate_keys[i][j] = col_names[unique_candidate_keys[i][j]];
                }
        }
        return unique_candidate_keys;
};