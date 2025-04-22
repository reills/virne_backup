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
  id 98
  arrival_time 1951.149341326895
  lifetime 138.2297751076459
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 45
    gpu 10
    rom 15
  ]
  node [
    id 1
    label "1"
    cpu 25
    gpu 28
    rom 28
  ]
  node [
    id 2
    label "2"
    cpu 33
    gpu 37
    rom 7
  ]
  node [
    id 3
    label "3"
    cpu 35
    gpu 45
    rom 17
  ]
  node [
    id 4
    label "4"
    cpu 45
    gpu 17
    rom 9
  ]
  node [
    id 5
    label "5"
    cpu 33
    gpu 39
    rom 27
  ]
  node [
    id 6
    label "6"
    cpu 46
    gpu 46
    rom 9
  ]
  edge [
    source 0
    target 1
    bw 45
  ]
  edge [
    source 1
    target 2
    bw 27
  ]
  edge [
    source 2
    target 3
    bw 26
  ]
  edge [
    source 3
    target 4
    bw 2
  ]
  edge [
    source 4
    target 5
    bw 10
  ]
  edge [
    source 5
    target 6
    bw 16
  ]
]
