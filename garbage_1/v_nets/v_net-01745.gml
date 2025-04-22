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
  id 1745
  arrival_time 38940.86786181081
  lifetime 658.8315928305398
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 17
    gpu 14
    rom 42
  ]
  node [
    id 1
    label "1"
    cpu 14
    gpu 30
    rom 20
  ]
  node [
    id 2
    label "2"
    cpu 44
    gpu 37
    rom 39
  ]
  node [
    id 3
    label "3"
    cpu 29
    gpu 3
    rom 25
  ]
  node [
    id 4
    label "4"
    cpu 4
    gpu 35
    rom 27
  ]
  node [
    id 5
    label "5"
    cpu 8
    gpu 18
    rom 1
  ]
  node [
    id 6
    label "6"
    cpu 43
    gpu 43
    rom 34
  ]
  node [
    id 7
    label "7"
    cpu 4
    gpu 50
    rom 26
  ]
  node [
    id 8
    label "8"
    cpu 5
    gpu 1
    rom 46
  ]
  edge [
    source 0
    target 1
    bw 33
  ]
  edge [
    source 1
    target 2
    bw 28
  ]
  edge [
    source 2
    target 3
    bw 7
  ]
  edge [
    source 3
    target 4
    bw 38
  ]
  edge [
    source 4
    target 5
    bw 35
  ]
  edge [
    source 5
    target 6
    bw 35
  ]
  edge [
    source 6
    target 7
    bw 26
  ]
  edge [
    source 7
    target 8
    bw 18
  ]
]
