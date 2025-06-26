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
  id 1672
  arrival_time 37300.38640984543
  lifetime 658.51633757715
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 11
    gpu 46
    rom 10
  ]
  node [
    id 1
    label "1"
    cpu 1
    gpu 14
    rom 25
  ]
  node [
    id 2
    label "2"
    cpu 16
    gpu 40
    rom 36
  ]
  node [
    id 3
    label "3"
    cpu 30
    gpu 2
    rom 16
  ]
  node [
    id 4
    label "4"
    cpu 44
    gpu 49
    rom 39
  ]
  edge [
    source 0
    target 1
    bw 49
  ]
  edge [
    source 1
    target 2
    bw 3
  ]
  edge [
    source 2
    target 3
    bw 31
  ]
  edge [
    source 3
    target 4
    bw 50
  ]
]
