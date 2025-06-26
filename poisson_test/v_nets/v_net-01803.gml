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
  id 1803
  arrival_time 40059.52577971032
  lifetime 2128.4973692469985
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 45
    gpu 34
    rom 4
  ]
  node [
    id 1
    label "1"
    cpu 22
    gpu 29
    rom 46
  ]
  node [
    id 2
    label "2"
    cpu 31
    gpu 29
    rom 0
  ]
  node [
    id 3
    label "3"
    cpu 9
    gpu 25
    rom 32
  ]
  node [
    id 4
    label "4"
    cpu 21
    gpu 0
    rom 37
  ]
  node [
    id 5
    label "5"
    cpu 30
    gpu 14
    rom 4
  ]
  node [
    id 6
    label "6"
    cpu 34
    gpu 19
    rom 23
  ]
  node [
    id 7
    label "7"
    cpu 14
    gpu 27
    rom 4
  ]
  node [
    id 8
    label "8"
    cpu 49
    gpu 3
    rom 33
  ]
  node [
    id 9
    label "9"
    cpu 31
    gpu 5
    rom 20
  ]
  node [
    id 10
    label "10"
    cpu 3
    gpu 42
    rom 29
  ]
  node [
    id 11
    label "11"
    cpu 33
    gpu 41
    rom 7
  ]
  node [
    id 12
    label "12"
    cpu 7
    gpu 42
    rom 25
  ]
  node [
    id 13
    label "13"
    cpu 35
    gpu 44
    rom 35
  ]
  node [
    id 14
    label "14"
    cpu 9
    gpu 32
    rom 48
  ]
  edge [
    source 0
    target 1
    bw 27
  ]
  edge [
    source 1
    target 2
    bw 10
  ]
  edge [
    source 2
    target 3
    bw 41
  ]
  edge [
    source 3
    target 4
    bw 3
  ]
  edge [
    source 4
    target 5
    bw 36
  ]
  edge [
    source 5
    target 6
    bw 16
  ]
  edge [
    source 6
    target 7
    bw 9
  ]
  edge [
    source 7
    target 8
    bw 47
  ]
  edge [
    source 8
    target 9
    bw 5
  ]
  edge [
    source 9
    target 10
    bw 21
  ]
  edge [
    source 10
    target 11
    bw 45
  ]
  edge [
    source 11
    target 12
    bw 13
  ]
  edge [
    source 12
    target 13
    bw 24
  ]
  edge [
    source 13
    target 14
    bw 23
  ]
]
