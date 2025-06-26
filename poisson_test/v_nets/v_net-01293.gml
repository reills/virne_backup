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
  id 1293
  arrival_time 27075.044605375002
  lifetime 2140.3136204533516
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 37
    gpu 6
    rom 10
  ]
  node [
    id 1
    label "1"
    cpu 9
    gpu 38
    rom 39
  ]
  node [
    id 2
    label "2"
    cpu 6
    gpu 21
    rom 33
  ]
  node [
    id 3
    label "3"
    cpu 14
    gpu 18
    rom 3
  ]
  node [
    id 4
    label "4"
    cpu 43
    gpu 15
    rom 28
  ]
  node [
    id 5
    label "5"
    cpu 21
    gpu 16
    rom 3
  ]
  node [
    id 6
    label "6"
    cpu 19
    gpu 50
    rom 46
  ]
  edge [
    source 0
    target 1
    bw 18
  ]
  edge [
    source 1
    target 2
    bw 15
  ]
  edge [
    source 2
    target 3
    bw 23
  ]
  edge [
    source 3
    target 4
    bw 43
  ]
  edge [
    source 4
    target 5
    bw 19
  ]
  edge [
    source 5
    target 6
    bw 47
  ]
]
