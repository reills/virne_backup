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
  id 1101
  arrival_time 22962.021475021516
  lifetime 25.84330906589291
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 35
    gpu 41
    rom 42
  ]
  node [
    id 1
    label "1"
    cpu 33
    gpu 50
    rom 34
  ]
  node [
    id 2
    label "2"
    cpu 38
    gpu 34
    rom 29
  ]
  node [
    id 3
    label "3"
    cpu 25
    gpu 5
    rom 31
  ]
  node [
    id 4
    label "4"
    cpu 18
    gpu 26
    rom 39
  ]
  node [
    id 5
    label "5"
    cpu 45
    gpu 17
    rom 13
  ]
  node [
    id 6
    label "6"
    cpu 36
    gpu 46
    rom 31
  ]
  node [
    id 7
    label "7"
    cpu 40
    gpu 9
    rom 44
  ]
  node [
    id 8
    label "8"
    cpu 44
    gpu 46
    rom 27
  ]
  node [
    id 9
    label "9"
    cpu 25
    gpu 8
    rom 43
  ]
  node [
    id 10
    label "10"
    cpu 30
    gpu 26
    rom 38
  ]
  node [
    id 11
    label "11"
    cpu 42
    gpu 0
    rom 4
  ]
  node [
    id 12
    label "12"
    cpu 15
    gpu 4
    rom 25
  ]
  node [
    id 13
    label "13"
    cpu 34
    gpu 13
    rom 20
  ]
  edge [
    source 0
    target 1
    bw 38
  ]
  edge [
    source 1
    target 2
    bw 32
  ]
  edge [
    source 2
    target 3
    bw 15
  ]
  edge [
    source 3
    target 4
    bw 39
  ]
  edge [
    source 4
    target 5
    bw 33
  ]
  edge [
    source 5
    target 6
    bw 43
  ]
  edge [
    source 6
    target 7
    bw 36
  ]
  edge [
    source 7
    target 8
    bw 17
  ]
  edge [
    source 8
    target 9
    bw 17
  ]
  edge [
    source 9
    target 10
    bw 39
  ]
  edge [
    source 10
    target 11
    bw 10
  ]
  edge [
    source 11
    target 12
    bw 25
  ]
  edge [
    source 12
    target 13
    bw 28
  ]
]
