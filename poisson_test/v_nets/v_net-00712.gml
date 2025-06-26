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
  id 712
  arrival_time 14863.913044422381
  lifetime 126.7483570290879
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 25
    gpu 38
    rom 37
  ]
  node [
    id 1
    label "1"
    cpu 10
    gpu 31
    rom 24
  ]
  node [
    id 2
    label "2"
    cpu 16
    gpu 20
    rom 12
  ]
  node [
    id 3
    label "3"
    cpu 2
    gpu 36
    rom 47
  ]
  node [
    id 4
    label "4"
    cpu 39
    gpu 5
    rom 45
  ]
  node [
    id 5
    label "5"
    cpu 4
    gpu 44
    rom 37
  ]
  node [
    id 6
    label "6"
    cpu 44
    gpu 24
    rom 48
  ]
  node [
    id 7
    label "7"
    cpu 41
    gpu 15
    rom 14
  ]
  node [
    id 8
    label "8"
    cpu 31
    gpu 42
    rom 40
  ]
  node [
    id 9
    label "9"
    cpu 15
    gpu 8
    rom 19
  ]
  node [
    id 10
    label "10"
    cpu 29
    gpu 17
    rom 43
  ]
  node [
    id 11
    label "11"
    cpu 24
    gpu 18
    rom 27
  ]
  node [
    id 12
    label "12"
    cpu 1
    gpu 31
    rom 48
  ]
  node [
    id 13
    label "13"
    cpu 13
    gpu 3
    rom 27
  ]
  edge [
    source 0
    target 1
    bw 41
  ]
  edge [
    source 1
    target 2
    bw 33
  ]
  edge [
    source 2
    target 3
    bw 6
  ]
  edge [
    source 3
    target 4
    bw 29
  ]
  edge [
    source 4
    target 5
    bw 41
  ]
  edge [
    source 5
    target 6
    bw 27
  ]
  edge [
    source 6
    target 7
    bw 6
  ]
  edge [
    source 7
    target 8
    bw 4
  ]
  edge [
    source 8
    target 9
    bw 8
  ]
  edge [
    source 9
    target 10
    bw 11
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
    bw 36
  ]
]
