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
  id 221
  arrival_time 4059.5047764354667
  lifetime 415.3934024355075
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 10
    gpu 22
    rom 0
  ]
  node [
    id 1
    label "1"
    cpu 31
    gpu 31
    rom 32
  ]
  node [
    id 2
    label "2"
    cpu 41
    gpu 29
    rom 48
  ]
  node [
    id 3
    label "3"
    cpu 37
    gpu 11
    rom 5
  ]
  node [
    id 4
    label "4"
    cpu 37
    gpu 30
    rom 29
  ]
  node [
    id 5
    label "5"
    cpu 14
    gpu 36
    rom 10
  ]
  node [
    id 6
    label "6"
    cpu 27
    gpu 18
    rom 31
  ]
  node [
    id 7
    label "7"
    cpu 18
    gpu 49
    rom 33
  ]
  node [
    id 8
    label "8"
    cpu 18
    gpu 27
    rom 0
  ]
  node [
    id 9
    label "9"
    cpu 26
    gpu 48
    rom 40
  ]
  node [
    id 10
    label "10"
    cpu 30
    gpu 44
    rom 34
  ]
  node [
    id 11
    label "11"
    cpu 21
    gpu 47
    rom 9
  ]
  node [
    id 12
    label "12"
    cpu 40
    gpu 15
    rom 16
  ]
  edge [
    source 0
    target 1
    bw 5
  ]
  edge [
    source 1
    target 2
    bw 2
  ]
  edge [
    source 2
    target 3
    bw 50
  ]
  edge [
    source 3
    target 4
    bw 18
  ]
  edge [
    source 4
    target 5
    bw 35
  ]
  edge [
    source 5
    target 6
    bw 11
  ]
  edge [
    source 6
    target 7
    bw 26
  ]
  edge [
    source 7
    target 8
    bw 12
  ]
  edge [
    source 8
    target 9
    bw 38
  ]
  edge [
    source 9
    target 10
    bw 27
  ]
  edge [
    source 10
    target 11
    bw 36
  ]
  edge [
    source 11
    target 12
    bw 30
  ]
]
