import { createClient } from 'https://esm.sh/@supabase/supabase-js@2';

const supabaseUrl = 'YOUR_PROJECT_URL';
const supabaseKey = 'sb_publishable_I_3He6ymOrSCQz6E8J71mQ_YX-UQn5r';

export const supabase = createClient(supabaseUrl, supabaseKey);