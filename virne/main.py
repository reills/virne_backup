from virne.base import BasicScenario
from virne import Config, REGISTRY, Generator, update_simulation_setting


def run(config):
    print(f"\n{'-' * 20}    Start     {'-' * 20}\n")
    # Load solver info: environment and solver class
    solver_info = REGISTRY.get(config.solver_name)
    Env, Solver = solver_info['env'], solver_info['solver']
    print(f'Use {config.solver_name} Solver (Type = {solver_info["type"]})...\n')

    scenario = BasicScenario.from_config(Env, Solver, config)
    scenario.run()

    print(f"\n{'-' * 20}   Complete   {'-' * 20}\n")


if __name__ == '__main__':
    config = Config(
        #solver_name='sa',
        #solver_name='a3c_gcn_seq2seq'
        #solver_name='a2c_gcn_transformer_encoder'
        #solver_name='a3c_gcn_oneshot_transformer'
        solver_name='a3c_gcn_pre_train_transformer'
        # p_net_setting_path='customized_p_net_setting_file_path',
        # v_sim_setting_path='customized_v_sim_setting_file_path',
    ) 
    
    config.max_seq_len = config.v_sim_setting['v_net_size']['high']

    Generator.generate_dataset(
        config,
        p_net=True,
        v_nets=True,
        save=True,
        reuse_existing_p=False,  
        reuse_existing_v=False
    )

    run(config) 

    #conda activate nfv-env
    # source nfv-env/bin/activate