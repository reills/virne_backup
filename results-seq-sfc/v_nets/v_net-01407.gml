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
  id 1407
  arrival_time 29456.976856040073
  lifetime 551.2675777517886
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 25
    gpu 27
    rom 30
  ]
  node [
    id 1
    label "1"
    cpu 41
    gpu 34
    rom 29
  ]
  node [
    id 2
    label "2"
    cpu 38
    gpu 17
    rom 42
  ]
  node [
    id 3
    label "3"
    cpu 9
    gpu 9
    rom 9
  ]
  node [
    id 4
    label "4"
    cpu 25
    gpu 22
    rom 12
  ]
  node [
    id 5
    label "5"
    cpu 47
    gpu 10
    rom 6
  ]
  node [
    id 6
    label "6"
    cpu 41
    gpu 23
    rom 3
  ]
  node [
    id 7
    label "7"
    cpu 39
    gpu 36
    rom 38
  ]
  node [
    id 8
    label "8"
    cpu 13
    gpu 23
    rom 3
  ]
  node [
    id 9
    label "9"
    cpu 4
    gpu 21
    rom 16
  ]
  node [
    id 10
    label "10"
    cpu 7
    gpu 27
    rom 0
  ]
  edge [
    source 0
    target 1
    bw 17
  ]
  edge [
    source 1
    target 2
    bw 47
  ]
  edge [
    source 2
    target 3
    bw 22
  ]
  edge [
    source 3
    target 4
    bw 16
  ]
  edge [
    source 4
    target 5
    bw 15
  ]
  edge [
    source 5
    target 6
    bw 15
  ]
  edge [
    source 6
    target 7
    bw 22
  ]
  edge [
    source 7
    target 8
    bw 4
  ]
  edge [
    source 8
    target 9
    bw 45
  ]
  edge [
    source 9
    target 10
    bw 12
  ]
]
