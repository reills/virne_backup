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
  id 1509
  arrival_time 33592.99834798785
  lifetime 464.5067685854006
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 14
    gpu 49
    rom 31
  ]
  node [
    id 1
    label "1"
    cpu 29
    gpu 47
    rom 11
  ]
  node [
    id 2
    label "2"
    cpu 1
    gpu 37
    rom 22
  ]
  node [
    id 3
    label "3"
    cpu 0
    gpu 4
    rom 14
  ]
  node [
    id 4
    label "4"
    cpu 11
    gpu 38
    rom 49
  ]
  node [
    id 5
    label "5"
    cpu 49
    gpu 9
    rom 30
  ]
  node [
    id 6
    label "6"
    cpu 18
    gpu 39
    rom 47
  ]
  node [
    id 7
    label "7"
    cpu 30
    gpu 18
    rom 41
  ]
  node [
    id 8
    label "8"
    cpu 19
    gpu 33
    rom 34
  ]
  node [
    id 9
    label "9"
    cpu 49
    gpu 48
    rom 14
  ]
  node [
    id 10
    label "10"
    cpu 30
    gpu 14
    rom 17
  ]
  node [
    id 11
    label "11"
    cpu 10
    gpu 17
    rom 0
  ]
  node [
    id 12
    label "12"
    cpu 14
    gpu 49
    rom 27
  ]
  node [
    id 13
    label "13"
    cpu 22
    gpu 20
    rom 49
  ]
  edge [
    source 0
    target 1
    bw 38
  ]
  edge [
    source 1
    target 2
    bw 50
  ]
  edge [
    source 2
    target 3
    bw 22
  ]
  edge [
    source 3
    target 4
    bw 50
  ]
  edge [
    source 4
    target 5
    bw 13
  ]
  edge [
    source 5
    target 6
    bw 41
  ]
  edge [
    source 6
    target 7
    bw 3
  ]
  edge [
    source 7
    target 8
    bw 33
  ]
  edge [
    source 8
    target 9
    bw 5
  ]
  edge [
    source 9
    target 10
    bw 26
  ]
  edge [
    source 10
    target 11
    bw 40
  ]
  edge [
    source 11
    target 12
    bw 12
  ]
  edge [
    source 12
    target 13
    bw 33
  ]
]
