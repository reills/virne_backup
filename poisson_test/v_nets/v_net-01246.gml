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
  id 1246
  arrival_time 25697.0385458394
  lifetime 2212.9060492946337
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 31
    gpu 36
    rom 16
  ]
  node [
    id 1
    label "1"
    cpu 23
    gpu 40
    rom 9
  ]
  node [
    id 2
    label "2"
    cpu 43
    gpu 37
    rom 43
  ]
  node [
    id 3
    label "3"
    cpu 2
    gpu 19
    rom 19
  ]
  node [
    id 4
    label "4"
    cpu 18
    gpu 30
    rom 19
  ]
  edge [
    source 0
    target 1
    bw 4
  ]
  edge [
    source 1
    target 2
    bw 33
  ]
  edge [
    source 2
    target 3
    bw 40
  ]
  edge [
    source 3
    target 4
    bw 43
  ]
]
