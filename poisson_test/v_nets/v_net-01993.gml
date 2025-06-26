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
  id 1993
  arrival_time 43464.397562066035
  lifetime 3994.5506993617005
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 2
    gpu 41
    rom 14
  ]
  node [
    id 1
    label "1"
    cpu 40
    gpu 6
    rom 9
  ]
  node [
    id 2
    label "2"
    cpu 1
    gpu 26
    rom 18
  ]
  node [
    id 3
    label "3"
    cpu 14
    gpu 26
    rom 35
  ]
  node [
    id 4
    label "4"
    cpu 18
    gpu 19
    rom 16
  ]
  node [
    id 5
    label "5"
    cpu 47
    gpu 3
    rom 27
  ]
  node [
    id 6
    label "6"
    cpu 34
    gpu 41
    rom 27
  ]
  node [
    id 7
    label "7"
    cpu 34
    gpu 31
    rom 24
  ]
  edge [
    source 0
    target 1
    bw 40
  ]
  edge [
    source 1
    target 2
    bw 1
  ]
  edge [
    source 2
    target 3
    bw 9
  ]
  edge [
    source 3
    target 4
    bw 15
  ]
  edge [
    source 4
    target 5
    bw 35
  ]
  edge [
    source 5
    target 6
    bw 0
  ]
  edge [
    source 6
    target 7
    bw 30
  ]
]
