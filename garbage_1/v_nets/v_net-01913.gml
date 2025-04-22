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
  id 1913
  arrival_time 42072.58913091945
  lifetime 935.2886115013135
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 44
    gpu 33
    rom 45
  ]
  node [
    id 1
    label "1"
    cpu 30
    gpu 19
    rom 2
  ]
  node [
    id 2
    label "2"
    cpu 12
    gpu 15
    rom 44
  ]
  node [
    id 3
    label "3"
    cpu 28
    gpu 9
    rom 9
  ]
  node [
    id 4
    label "4"
    cpu 9
    gpu 32
    rom 37
  ]
  node [
    id 5
    label "5"
    cpu 21
    gpu 23
    rom 16
  ]
  node [
    id 6
    label "6"
    cpu 5
    gpu 17
    rom 2
  ]
  node [
    id 7
    label "7"
    cpu 18
    gpu 42
    rom 40
  ]
  edge [
    source 0
    target 1
    bw 20
  ]
  edge [
    source 1
    target 2
    bw 11
  ]
  edge [
    source 2
    target 3
    bw 30
  ]
  edge [
    source 3
    target 4
    bw 21
  ]
  edge [
    source 4
    target 5
    bw 32
  ]
  edge [
    source 5
    target 6
    bw 4
  ]
  edge [
    source 6
    target 7
    bw 50
  ]
]
