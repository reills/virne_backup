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
  id 1305
  arrival_time 27291.130454870734
  lifetime 211.0914900603929
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 35
    gpu 48
    rom 31
  ]
  node [
    id 1
    label "1"
    cpu 48
    gpu 0
    rom 34
  ]
  node [
    id 2
    label "2"
    cpu 26
    gpu 4
    rom 11
  ]
  node [
    id 3
    label "3"
    cpu 48
    gpu 19
    rom 30
  ]
  node [
    id 4
    label "4"
    cpu 19
    gpu 31
    rom 32
  ]
  node [
    id 5
    label "5"
    cpu 49
    gpu 33
    rom 38
  ]
  node [
    id 6
    label "6"
    cpu 41
    gpu 0
    rom 39
  ]
  node [
    id 7
    label "7"
    cpu 21
    gpu 25
    rom 14
  ]
  node [
    id 8
    label "8"
    cpu 37
    gpu 9
    rom 35
  ]
  node [
    id 9
    label "9"
    cpu 27
    gpu 11
    rom 14
  ]
  node [
    id 10
    label "10"
    cpu 15
    gpu 49
    rom 26
  ]
  node [
    id 11
    label "11"
    cpu 42
    gpu 18
    rom 9
  ]
  node [
    id 12
    label "12"
    cpu 3
    gpu 45
    rom 10
  ]
  node [
    id 13
    label "13"
    cpu 40
    gpu 14
    rom 47
  ]
  node [
    id 14
    label "14"
    cpu 34
    gpu 9
    rom 45
  ]
  edge [
    source 0
    target 1
    bw 21
  ]
  edge [
    source 1
    target 2
    bw 44
  ]
  edge [
    source 2
    target 3
    bw 18
  ]
  edge [
    source 3
    target 4
    bw 21
  ]
  edge [
    source 4
    target 5
    bw 36
  ]
  edge [
    source 5
    target 6
    bw 14
  ]
  edge [
    source 6
    target 7
    bw 8
  ]
  edge [
    source 7
    target 8
    bw 46
  ]
  edge [
    source 8
    target 9
    bw 13
  ]
  edge [
    source 9
    target 10
    bw 8
  ]
  edge [
    source 10
    target 11
    bw 35
  ]
  edge [
    source 11
    target 12
    bw 9
  ]
  edge [
    source 12
    target 13
    bw 45
  ]
  edge [
    source 13
    target 14
    bw 7
  ]
]
