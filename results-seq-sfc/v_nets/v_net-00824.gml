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
  id 824
  arrival_time 17068.528853703658
  lifetime 2893.264743974207
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 0
    gpu 11
    rom 1
  ]
  node [
    id 1
    label "1"
    cpu 23
    gpu 36
    rom 41
  ]
  node [
    id 2
    label "2"
    cpu 41
    gpu 23
    rom 40
  ]
  node [
    id 3
    label "3"
    cpu 19
    gpu 30
    rom 49
  ]
  edge [
    source 0
    target 1
    bw 35
  ]
  edge [
    source 1
    target 2
    bw 20
  ]
  edge [
    source 2
    target 3
    bw 29
  ]
]
