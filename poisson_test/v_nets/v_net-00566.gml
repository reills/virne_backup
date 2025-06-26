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
  id 566
  arrival_time 10710.83668460992
  lifetime 523.5842848487966
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 44
    gpu 1
    rom 20
  ]
  node [
    id 1
    label "1"
    cpu 2
    gpu 7
    rom 27
  ]
  node [
    id 2
    label "2"
    cpu 39
    gpu 3
    rom 43
  ]
  node [
    id 3
    label "3"
    cpu 21
    gpu 46
    rom 50
  ]
  node [
    id 4
    label "4"
    cpu 32
    gpu 17
    rom 50
  ]
  node [
    id 5
    label "5"
    cpu 18
    gpu 32
    rom 25
  ]
  node [
    id 6
    label "6"
    cpu 14
    gpu 1
    rom 12
  ]
  node [
    id 7
    label "7"
    cpu 46
    gpu 20
    rom 12
  ]
  node [
    id 8
    label "8"
    cpu 33
    gpu 45
    rom 17
  ]
  node [
    id 9
    label "9"
    cpu 2
    gpu 10
    rom 17
  ]
  node [
    id 10
    label "10"
    cpu 15
    gpu 36
    rom 47
  ]
  node [
    id 11
    label "11"
    cpu 17
    gpu 29
    rom 49
  ]
  edge [
    source 0
    target 1
    bw 29
  ]
  edge [
    source 1
    target 2
    bw 11
  ]
  edge [
    source 2
    target 3
    bw 45
  ]
  edge [
    source 3
    target 4
    bw 40
  ]
  edge [
    source 4
    target 5
    bw 27
  ]
  edge [
    source 5
    target 6
    bw 47
  ]
  edge [
    source 6
    target 7
    bw 0
  ]
  edge [
    source 7
    target 8
    bw 3
  ]
  edge [
    source 8
    target 9
    bw 1
  ]
  edge [
    source 9
    target 10
    bw 23
  ]
  edge [
    source 10
    target 11
    bw 38
  ]
]
