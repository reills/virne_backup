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
  id 432
  arrival_time 8413.944580129923
  lifetime 455.8296895633873
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 45
    gpu 31
    rom 3
  ]
  node [
    id 1
    label "1"
    cpu 38
    gpu 33
    rom 29
  ]
  node [
    id 2
    label "2"
    cpu 50
    gpu 39
    rom 17
  ]
  node [
    id 3
    label "3"
    cpu 45
    gpu 28
    rom 18
  ]
  node [
    id 4
    label "4"
    cpu 33
    gpu 26
    rom 11
  ]
  node [
    id 5
    label "5"
    cpu 22
    gpu 13
    rom 48
  ]
  node [
    id 6
    label "6"
    cpu 31
    gpu 25
    rom 30
  ]
  node [
    id 7
    label "7"
    cpu 41
    gpu 11
    rom 44
  ]
  node [
    id 8
    label "8"
    cpu 37
    gpu 17
    rom 24
  ]
  node [
    id 9
    label "9"
    cpu 29
    gpu 31
    rom 15
  ]
  node [
    id 10
    label "10"
    cpu 20
    gpu 35
    rom 25
  ]
  node [
    id 11
    label "11"
    cpu 20
    gpu 26
    rom 20
  ]
  node [
    id 12
    label "12"
    cpu 35
    gpu 11
    rom 14
  ]
  edge [
    source 0
    target 1
    bw 35
  ]
  edge [
    source 1
    target 2
    bw 49
  ]
  edge [
    source 2
    target 3
    bw 25
  ]
  edge [
    source 3
    target 4
    bw 42
  ]
  edge [
    source 4
    target 5
    bw 2
  ]
  edge [
    source 5
    target 6
    bw 7
  ]
  edge [
    source 6
    target 7
    bw 48
  ]
  edge [
    source 7
    target 8
    bw 2
  ]
  edge [
    source 8
    target 9
    bw 0
  ]
  edge [
    source 9
    target 10
    bw 43
  ]
  edge [
    source 10
    target 11
    bw 10
  ]
  edge [
    source 11
    target 12
    bw 47
  ]
]
