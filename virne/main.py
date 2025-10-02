from virne.base import BasicScenario
from virne import Config, REGISTRY, Generator, update_simulation_setting
import argparse
from virne.utils.setting import read_setting


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
    parser = argparse.ArgumentParser(description='Run VIRNE main with optional external config')
    parser.add_argument('--config', type=str, help='Path to a YAML/JSON config file to load')
    parser.add_argument('--skip-generate', action='store_true', help='Skip dataset generation step')
    args, unknown = parser.parse_known_args()

    if args.config:
        cfg_dict = read_setting(args.config)
        config = Config.load(cfg_dict)
    else:
        config = Config(
            solver_name='a3c_gcn_pre_train_transformer'
        )

    # Ensure max sequence length reflects dataset v_net_size
    config.max_seq_len = config.v_sim_setting['v_net_size']['high']

    # Optionally generate datasets. Default behavior preserved unless --skip-generate provided.
    if not args.skip_generate:
        Generator.generate_dataset(
            config,
            p_net=True,
            v_nets=True,
            save=True,
            reuse_existing_p=True,
            reuse_existing_v=True
        )

    run(config)
