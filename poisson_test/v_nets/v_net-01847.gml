graph [
  node_attrs_setting [
    name "cpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "gpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "rom"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  link_attrs_setting "_networkx_list_start"
  link_attrs_setting [
    name "bw"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "link"
    type "resource"
  ]
  id 1847
  arrival_time 40802.487913714074
  lifetime 892.9461255620301
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 47
    gpu 29
    rom 45
  ]
  node [
    id 1
    label "1"
    cpu 50
    gpu 29
    rom 17
  ]
  edge [
    source 0
    target 1
    bw 28
  ]
]
