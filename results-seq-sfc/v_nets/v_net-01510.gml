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
  id 1510
  arrival_time 33593.65390313409
  lifetime 2011.743953938379
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 4
    gpu 50
    rom 12
  ]
  node [
    id 1
    label "1"
    cpu 18
    gpu 21
    rom 8
  ]
  node [
    id 2
    label "2"
    cpu 47
    gpu 31
    rom 9
  ]
  node [
    id 3
    label "3"
    cpu 28
    gpu 19
    rom 31
  ]
  node [
    id 4
    label "4"
    cpu 5
    gpu 34
    rom 3
  ]
  node [
    id 5
    label "5"
    cpu 0
    gpu 5
    rom 27
  ]
  node [
    id 6
    label "6"
    cpu 1
    gpu 45
    rom 42
  ]
  node [
    id 7
    label "7"
    cpu 31
    gpu 3
    rom 41
  ]
  node [
    id 8
    label "8"
    cpu 46
    gpu 39
    rom 17
  ]
  node [
    id 9
    label "9"
    cpu 9
    gpu 43
    rom 40
  ]
  node [
    id 10
    label "10"
    cpu 6
    gpu 22
    rom 7
  ]
  node [
    id 11
    label "11"
    cpu 36
    gpu 28
    rom 5
  ]
  edge [
    source 0
    target 1
    bw 37
  ]
  edge [
    source 1
    target 2
    bw 38
  ]
  edge [
    source 2
    target 3
    bw 27
  ]
  edge [
    source 3
    target 4
    bw 2
  ]
  edge [
    source 4
    target 5
    bw 39
  ]
  edge [
    source 5
    target 6
    bw 41
  ]
  edge [
    source 6
    target 7
    bw 29
  ]
  edge [
    source 7
    target 8
    bw 9
  ]
  edge [
    source 8
    target 9
    bw 46
  ]
  edge [
    source 9
    target 10
    bw 30
  ]
  edge [
    source 10
    target 11
    bw 32
  ]
]
