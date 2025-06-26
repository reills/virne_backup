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
  id 1865
  arrival_time 40946.19972859589
  lifetime 856.2917883136871
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 1
    gpu 15
    rom 42
  ]
  node [
    id 1
    label "1"
    cpu 8
    gpu 17
    rom 22
  ]
  edge [
    source 0
    target 1
    bw 8
  ]
]
