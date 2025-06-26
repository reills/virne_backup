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
  id 345
  arrival_time 6575.994767420152
  lifetime 329.25888752453756
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 27
    gpu 23
    rom 50
  ]
  node [
    id 1
    label "1"
    cpu 23
    gpu 37
    rom 1
  ]
  node [
    id 2
    label "2"
    cpu 14
    gpu 5
    rom 34
  ]
  node [
    id 3
    label "3"
    cpu 9
    gpu 31
    rom 9
  ]
  node [
    id 4
    label "4"
    cpu 3
    gpu 28
    rom 16
  ]
  node [
    id 5
    label "5"
    cpu 4
    gpu 14
    rom 4
  ]
  node [
    id 6
    label "6"
    cpu 19
    gpu 9
    rom 41
  ]
  node [
    id 7
    label "7"
    cpu 36
    gpu 2
    rom 9
  ]
  node [
    id 8
    label "8"
    cpu 48
    gpu 42
    rom 30
  ]
  node [
    id 9
    label "9"
    cpu 36
    gpu 18
    rom 48
  ]
  node [
    id 10
    label "10"
    cpu 49
    gpu 13
    rom 12
  ]
  node [
    id 11
    label "11"
    cpu 24
    gpu 39
    rom 1
  ]
  node [
    id 12
    label "12"
    cpu 13
    gpu 50
    rom 42
  ]
  edge [
    source 0
    target 1
    bw 26
  ]
  edge [
    source 1
    target 2
    bw 36
  ]
  edge [
    source 2
    target 3
    bw 25
  ]
  edge [
    source 3
    target 4
    bw 21
  ]
  edge [
    source 4
    target 5
    bw 39
  ]
  edge [
    source 5
    target 6
    bw 48
  ]
  edge [
    source 6
    target 7
    bw 27
  ]
  edge [
    source 7
    target 8
    bw 9
  ]
  edge [
    source 8
    target 9
    bw 41
  ]
  edge [
    source 9
    target 10
    bw 2
  ]
  edge [
    source 10
    target 11
    bw 15
  ]
  edge [
    source 11
    target 12
    bw 24
  ]
]
