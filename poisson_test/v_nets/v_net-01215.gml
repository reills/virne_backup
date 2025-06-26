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
  id 1215
  arrival_time 25266.351389280724
  lifetime 464.88807624812904
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 49
    gpu 36
    rom 19
  ]
  node [
    id 1
    label "1"
    cpu 0
    gpu 23
    rom 7
  ]
  node [
    id 2
    label "2"
    cpu 26
    gpu 20
    rom 6
  ]
  node [
    id 3
    label "3"
    cpu 0
    gpu 3
    rom 7
  ]
  node [
    id 4
    label "4"
    cpu 21
    gpu 36
    rom 43
  ]
  node [
    id 5
    label "5"
    cpu 32
    gpu 5
    rom 21
  ]
  node [
    id 6
    label "6"
    cpu 0
    gpu 37
    rom 10
  ]
  node [
    id 7
    label "7"
    cpu 44
    gpu 34
    rom 34
  ]
  node [
    id 8
    label "8"
    cpu 6
    gpu 48
    rom 9
  ]
  edge [
    source 0
    target 1
    bw 17
  ]
  edge [
    source 1
    target 2
    bw 42
  ]
  edge [
    source 2
    target 3
    bw 42
  ]
  edge [
    source 3
    target 4
    bw 9
  ]
  edge [
    source 4
    target 5
    bw 27
  ]
  edge [
    source 5
    target 6
    bw 16
  ]
  edge [
    source 6
    target 7
    bw 1
  ]
  edge [
    source 7
    target 8
    bw 39
  ]
]
