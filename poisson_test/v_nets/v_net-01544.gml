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
  id 1544
  arrival_time 34152.06797641666
  lifetime 2703.9313778337378
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 50
    gpu 20
    rom 45
  ]
  node [
    id 1
    label "1"
    cpu 29
    gpu 18
    rom 13
  ]
  node [
    id 2
    label "2"
    cpu 34
    gpu 45
    rom 49
  ]
  node [
    id 3
    label "3"
    cpu 2
    gpu 11
    rom 47
  ]
  edge [
    source 0
    target 1
    bw 33
  ]
  edge [
    source 1
    target 2
    bw 18
  ]
  edge [
    source 2
    target 3
    bw 31
  ]
]
