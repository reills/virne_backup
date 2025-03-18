# ==============================================================================
# Copyright 2023 GeminiLight (wtfly2018@gmail.com). All Rights Reserved.
# ==============================================================================


import os
import random
import numpy as np

from .physical_network import PhysicalNetwork
from .virtual_network_request_simulator import VirtualNetworkRequestSimulator
from virne.utils import get_p_net_dataset_dir_from_setting, get_v_nets_dataset_dir_from_setting


class Generator:

    @staticmethod
    def generate_dataset(config, p_net=True, v_nets=True, save=False, reuse_existing_p=False, reuse_existing_v=False):
        """
        Generate a dataset consisting of a physical network and a virtual network request simulator.

        Args:
            config (dict or object): Configuration object containing the settings for the generator.
            p_net (bool): Whether or not to generate a physical network dataset.
            v_nets (bool): Whether or not to generate a virtual network request simulator dataset.
            save (bool): Whether or not to save the generated datasets.
            reuse_existing_p (bool): Whether to reuse an existing physical network dataset if available.
            reuse_existing_v (bool): Whether to reuse an existing virtual network dataset if available.

        Returns:
            Tuple: A tuple consisting of the generated physical network and virtual network request simulator.
        """
        physical_network = Generator.generate_p_net_dataset_from_config(config, save=save, reuse_existing=reuse_existing_p) if p_net else None
        v_net_simulator = Generator.generate_v_nets_dataset_from_config(config, save=save, reuse_existing=reuse_existing_v) if v_nets else None
        return physical_network, v_net_simulator

    @staticmethod
    def generate_p_net_dataset_from_config(config, save=False, reuse_existing=False):
        """Generate a physical network dataset from config, reusing existing if specified.

        Args:
            config (dict or object): Configuration object containing the settings for the generator.
            save (bool): Whether or not to save the generated dataset.
            reuse_existing (bool): Whether to reuse an existing physical network dataset if available.

        Returns:
            PhysicalNetwork: A PhysicalNetwork object representing the generated dataset.
        """
        if not isinstance(config, dict):
            config = vars(config)
        p_net_setting = config['p_net_setting']
        random.seed(config['seed'])
        np.random.seed(config['seed'])
        
        #p_net_dataset_dir = get_p_net_dataset_dir_from_setting(p_net_setting) #moved to top
        p_net_dataset_dir = p_net_setting.get('save_dir')
        if reuse_existing and os.path.exists(p_net_dataset_dir):
            p_net = PhysicalNetwork.load_dataset(p_net_dataset_dir)
            if config.get('verbose', 1):
                print(f'GENERATOR Loaded physical network dataset from {p_net_dataset_dir}')
        else:
           p_net = PhysicalNetwork.from_setting(p_net_setting)

        if save:
            #p_net_dataset_dir = get_p_net_dataset_dir_from_setting(p_net_setting)
            p_net.save_dataset(p_net_dataset_dir)
            if config.get('verbose', 1):
                print(f'save p_net dataset in {p_net_dataset_dir}')

    @staticmethod
    def generate_v_nets_dataset_from_config(config, save=False, reuse_existing=False):
        """
        Generate a virtual network request simulator dataset based on the given configuration.

        Args:
            config (dict or object): Configuration object containing the settings for the generator.
            save (bool): Whether or not to save the generated dataset.
            reuse_existing (bool): Whether to reuse an existing virtual network dataset if available.

        Returns:
            VirtualNetworkRequestSimulator: A VirtualNetworkRequestSimulator object representing the generated dataset.
        """
        if not isinstance(config, dict):
            config = vars(config)
        v_sim_setting = config['v_sim_setting']
        random.seed(config['seed'])
        np.random.seed(config['seed'])

        v_net_simulator = VirtualNetworkRequestSimulator.from_setting(v_sim_setting)
        v_net_simulator.renew()

        #v_nets_dataset_dir = get_v_nets_dataset_dir_from_setting(v_sim_setting) #moved to top
        v_nets_dataset_dir = v_sim_setting.get('save_dir')
        if reuse_existing and os.path.exists(v_nets_dataset_dir):
            v_net_simulator = VirtualNetworkRequestSimulator.load_dataset(v_nets_dataset_dir)
            if config.get('verbose', 1):
                print(f'Loaded virtual network dataset from {v_nets_dataset_dir}')
        else:
            v_net_simulator = VirtualNetworkRequestSimulator.from_setting(v_sim_setting)
            v_net_simulator.renew()  # generate new data.
            if save:
                v_net_simulator.save_dataset(v_nets_dataset_dir)
                if config.get('verbose', 1):
                    print(f'Saved virtual network dataset to {v_nets_dataset_dir}')
        return v_net_simulator
        