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
  id 1867
  arrival_time 40962.03554471322
  lifetime 426.8853590987491
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 49
    gpu 36
    rom 22
  ]
  node [
    id 1
    label "1"
    cpu 46
    gpu 16
    rom 0
  ]
  node [
    id 2
    label "2"
    cpu 47
    gpu 33
    rom 27
  ]
  node [
    id 3
    label "3"
    cpu 40
    gpu 27
    rom 37
  ]
  node [
    id 4
    label "4"
    cpu 15
    gpu 1
    rom 36
  ]
  edge [
    source 0
    target 1
    bw 8
  ]
  edge [
    source 1
    target 2
    bw 12
  ]
  edge [
    source 2
    target 3
    bw 19
  ]
  edge [
    source 3
    target 4
    bw 9
  ]
]
