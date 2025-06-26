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
  id 732
  arrival_time 15354.262969397954
  lifetime 957.0294740314087
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 30
    gpu 26
    rom 11
  ]
  node [
    id 1
    label "1"
    cpu 20
    gpu 24
    rom 11
  ]
  node [
    id 2
    label "2"
    cpu 31
    gpu 30
    rom 27
  ]
  node [
    id 3
    label "3"
    cpu 44
    gpu 9
    rom 50
  ]
  node [
    id 4
    label "4"
    cpu 46
    gpu 23
    rom 12
  ]
  node [
    id 5
    label "5"
    cpu 47
    gpu 38
    rom 22
  ]
  node [
    id 6
    label "6"
    cpu 15
    gpu 49
    rom 34
  ]
  node [
    id 7
    label "7"
    cpu 29
    gpu 27
    rom 13
  ]
  node [
    id 8
    label "8"
    cpu 21
    gpu 39
    rom 29
  ]
  node [
    id 9
    label "9"
    cpu 1
    gpu 23
    rom 42
  ]
  node [
    id 10
    label "10"
    cpu 1
    gpu 35
    rom 35
  ]
  node [
    id 11
    label "11"
    cpu 44
    gpu 21
    rom 24
  ]
  node [
    id 12
    label "12"
    cpu 37
    gpu 34
    rom 50
  ]
  edge [
    source 0
    target 1
    bw 39
  ]
  edge [
    source 1
    target 2
    bw 32
  ]
  edge [
    source 2
    target 3
    bw 37
  ]
  edge [
    source 3
    target 4
    bw 34
  ]
  edge [
    source 4
    target 5
    bw 48
  ]
  edge [
    source 5
    target 6
    bw 38
  ]
  edge [
    source 6
    target 7
    bw 36
  ]
  edge [
    source 7
    target 8
    bw 13
  ]
  edge [
    source 8
    target 9
    bw 47
  ]
  edge [
    source 9
    target 10
    bw 17
  ]
  edge [
    source 10
    target 11
    bw 35
  ]
  edge [
    source 11
    target 12
    bw 46
  ]
]
