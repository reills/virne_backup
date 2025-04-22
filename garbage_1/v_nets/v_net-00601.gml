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
  id 601
  arrival_time 12410.983348959322
  lifetime 552.5373103559872
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 36
    gpu 6
    rom 11
  ]
  node [
    id 1
    label "1"
    cpu 34
    gpu 48
    rom 34
  ]
  node [
    id 2
    label "2"
    cpu 42
    gpu 28
    rom 42
  ]
  node [
    id 3
    label "3"
    cpu 21
    gpu 26
    rom 44
  ]
  node [
    id 4
    label "4"
    cpu 15
    gpu 13
    rom 10
  ]
  node [
    id 5
    label "5"
    cpu 24
    gpu 24
    rom 2
  ]
  node [
    id 6
    label "6"
    cpu 38
    gpu 28
    rom 40
  ]
  node [
    id 7
    label "7"
    cpu 30
    gpu 47
    rom 13
  ]
  node [
    id 8
    label "8"
    cpu 11
    gpu 3
    rom 6
  ]
  node [
    id 9
    label "9"
    cpu 37
    gpu 10
    rom 33
  ]
  node [
    id 10
    label "10"
    cpu 8
    gpu 20
    rom 35
  ]
  edge [
    source 0
    target 1
    bw 19
  ]
  edge [
    source 1
    target 2
    bw 14
  ]
  edge [
    source 2
    target 3
    bw 12
  ]
  edge [
    source 3
    target 4
    bw 49
  ]
  edge [
    source 4
    target 5
    bw 47
  ]
  edge [
    source 5
    target 6
    bw 32
  ]
  edge [
    source 6
    target 7
    bw 38
  ]
  edge [
    source 7
    target 8
    bw 16
  ]
  edge [
    source 8
    target 9
    bw 27
  ]
  edge [
    source 9
    target 10
    bw 45
  ]
]
