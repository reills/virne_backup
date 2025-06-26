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
  id 1319
  arrival_time 27624.41304780599
  lifetime 891.1153146410401
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 39
    gpu 4
    rom 37
  ]
  node [
    id 1
    label "1"
    cpu 15
    gpu 13
    rom 1
  ]
  node [
    id 2
    label "2"
    cpu 9
    gpu 50
    rom 23
  ]
  node [
    id 3
    label "3"
    cpu 7
    gpu 19
    rom 6
  ]
  node [
    id 4
    label "4"
    cpu 4
    gpu 6
    rom 37
  ]
  node [
    id 5
    label "5"
    cpu 6
    gpu 45
    rom 5
  ]
  edge [
    source 0
    target 1
    bw 1
  ]
  edge [
    source 1
    target 2
    bw 12
  ]
  edge [
    source 2
    target 3
    bw 22
  ]
  edge [
    source 3
    target 4
    bw 47
  ]
  edge [
    source 4
    target 5
    bw 49
  ]
]
