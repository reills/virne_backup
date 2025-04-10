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
  id 1309
  arrival_time 27469.56324491566
  lifetime 261.07882134767755
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 17
    gpu 26
    rom 37
  ]
  node [
    id 1
    label "1"
    cpu 34
    gpu 7
    rom 8
  ]
  node [
    id 2
    label "2"
    cpu 47
    gpu 25
    rom 6
  ]
  node [
    id 3
    label "3"
    cpu 5
    gpu 34
    rom 34
  ]
  node [
    id 4
    label "4"
    cpu 17
    gpu 46
    rom 49
  ]
  node [
    id 5
    label "5"
    cpu 47
    gpu 47
    rom 31
  ]
  node [
    id 6
    label "6"
    cpu 50
    gpu 15
    rom 26
  ]
  node [
    id 7
    label "7"
    cpu 44
    gpu 44
    rom 30
  ]
  node [
    id 8
    label "8"
    cpu 46
    gpu 25
    rom 41
  ]
  node [
    id 9
    label "9"
    cpu 23
    gpu 24
    rom 25
  ]
  node [
    id 10
    label "10"
    cpu 37
    gpu 44
    rom 8
  ]
  node [
    id 11
    label "11"
    cpu 20
    gpu 31
    rom 46
  ]
  node [
    id 12
    label "12"
    cpu 32
    gpu 22
    rom 26
  ]
  node [
    id 13
    label "13"
    cpu 29
    gpu 41
    rom 18
  ]
  node [
    id 14
    label "14"
    cpu 10
    gpu 6
    rom 26
  ]
  edge [
    source 0
    target 1
    bw 15
  ]
  edge [
    source 1
    target 2
    bw 30
  ]
  edge [
    source 2
    target 3
    bw 25
  ]
  edge [
    source 3
    target 4
    bw 37
  ]
  edge [
    source 4
    target 5
    bw 16
  ]
  edge [
    source 5
    target 6
    bw 13
  ]
  edge [
    source 6
    target 7
    bw 35
  ]
  edge [
    source 7
    target 8
    bw 30
  ]
  edge [
    source 8
    target 9
    bw 41
  ]
  edge [
    source 9
    target 10
    bw 14
  ]
  edge [
    source 10
    target 11
    bw 36
  ]
  edge [
    source 11
    target 12
    bw 48
  ]
  edge [
    source 12
    target 13
    bw 33
  ]
  edge [
    source 13
    target 14
    bw 2
  ]
]
