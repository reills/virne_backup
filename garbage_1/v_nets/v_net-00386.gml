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
  id 386
  arrival_time 7643.461048800992
  lifetime 538.0775369912133
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 30
    gpu 11
    rom 33
  ]
  node [
    id 1
    label "1"
    cpu 34
    gpu 36
    rom 33
  ]
  node [
    id 2
    label "2"
    cpu 10
    gpu 6
    rom 21
  ]
  node [
    id 3
    label "3"
    cpu 48
    gpu 45
    rom 50
  ]
  node [
    id 4
    label "4"
    cpu 36
    gpu 40
    rom 18
  ]
  node [
    id 5
    label "5"
    cpu 19
    gpu 47
    rom 27
  ]
  node [
    id 6
    label "6"
    cpu 6
    gpu 49
    rom 26
  ]
  node [
    id 7
    label "7"
    cpu 18
    gpu 31
    rom 16
  ]
  node [
    id 8
    label "8"
    cpu 23
    gpu 1
    rom 5
  ]
  node [
    id 9
    label "9"
    cpu 12
    gpu 15
    rom 24
  ]
  node [
    id 10
    label "10"
    cpu 24
    gpu 6
    rom 32
  ]
  node [
    id 11
    label "11"
    cpu 28
    gpu 40
    rom 50
  ]
  node [
    id 12
    label "12"
    cpu 11
    gpu 9
    rom 35
  ]
  node [
    id 13
    label "13"
    cpu 11
    gpu 42
    rom 11
  ]
  edge [
    source 0
    target 1
    bw 8
  ]
  edge [
    source 1
    target 2
    bw 29
  ]
  edge [
    source 2
    target 3
    bw 10
  ]
  edge [
    source 3
    target 4
    bw 25
  ]
  edge [
    source 4
    target 5
    bw 9
  ]
  edge [
    source 5
    target 6
    bw 7
  ]
  edge [
    source 6
    target 7
    bw 39
  ]
  edge [
    source 7
    target 8
    bw 34
  ]
  edge [
    source 8
    target 9
    bw 43
  ]
  edge [
    source 9
    target 10
    bw 3
  ]
  edge [
    source 10
    target 11
    bw 19
  ]
  edge [
    source 11
    target 12
    bw 0
  ]
  edge [
    source 12
    target 13
    bw 48
  ]
]
