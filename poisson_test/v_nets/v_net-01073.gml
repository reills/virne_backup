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
  id 1073
  arrival_time 22473.512591443974
  lifetime 823.5867158476163
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 9
    gpu 46
    rom 44
  ]
  node [
    id 1
    label "1"
    cpu 3
    gpu 15
    rom 16
  ]
  node [
    id 2
    label "2"
    cpu 40
    gpu 6
    rom 21
  ]
  node [
    id 3
    label "3"
    cpu 0
    gpu 35
    rom 48
  ]
  edge [
    source 0
    target 1
    bw 5
  ]
  edge [
    source 1
    target 2
    bw 33
  ]
  edge [
    source 2
    target 3
    bw 46
  ]
]
