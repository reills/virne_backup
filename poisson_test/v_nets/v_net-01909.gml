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
  id 1909
  arrival_time 42030.138332762304
  lifetime 3127.5262726937162
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 29
    gpu 21
    rom 17
  ]
  node [
    id 1
    label "1"
    cpu 17
    gpu 0
    rom 49
  ]
  node [
    id 2
    label "2"
    cpu 22
    gpu 0
    rom 18
  ]
  node [
    id 3
    label "3"
    cpu 2
    gpu 2
    rom 47
  ]
  node [
    id 4
    label "4"
    cpu 34
    gpu 46
    rom 36
  ]
  node [
    id 5
    label "5"
    cpu 20
    gpu 1
    rom 11
  ]
  node [
    id 6
    label "6"
    cpu 14
    gpu 35
    rom 41
  ]
  node [
    id 7
    label "7"
    cpu 36
    gpu 26
    rom 5
  ]
  node [
    id 8
    label "8"
    cpu 10
    gpu 15
    rom 50
  ]
  node [
    id 9
    label "9"
    cpu 20
    gpu 32
    rom 12
  ]
  node [
    id 10
    label "10"
    cpu 23
    gpu 11
    rom 15
  ]
  node [
    id 11
    label "11"
    cpu 6
    gpu 43
    rom 24
  ]
  node [
    id 12
    label "12"
    cpu 5
    gpu 48
    rom 25
  ]
  node [
    id 13
    label "13"
    cpu 48
    gpu 44
    rom 35
  ]
  edge [
    source 0
    target 1
    bw 47
  ]
  edge [
    source 1
    target 2
    bw 12
  ]
  edge [
    source 2
    target 3
    bw 3
  ]
  edge [
    source 3
    target 4
    bw 7
  ]
  edge [
    source 4
    target 5
    bw 33
  ]
  edge [
    source 5
    target 6
    bw 15
  ]
  edge [
    source 6
    target 7
    bw 24
  ]
  edge [
    source 7
    target 8
    bw 24
  ]
  edge [
    source 8
    target 9
    bw 40
  ]
  edge [
    source 9
    target 10
    bw 12
  ]
  edge [
    source 10
    target 11
    bw 46
  ]
  edge [
    source 11
    target 12
    bw 28
  ]
  edge [
    source 12
    target 13
    bw 25
  ]
]
