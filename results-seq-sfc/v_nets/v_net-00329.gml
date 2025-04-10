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
  id 329
  arrival_time 6323.877668369072
  lifetime 1446.8971262942393
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 49
    gpu 30
    rom 25
  ]
  node [
    id 1
    label "1"
    cpu 11
    gpu 7
    rom 8
  ]
  node [
    id 2
    label "2"
    cpu 43
    gpu 15
    rom 15
  ]
  node [
    id 3
    label "3"
    cpu 10
    gpu 41
    rom 10
  ]
  node [
    id 4
    label "4"
    cpu 31
    gpu 21
    rom 22
  ]
  node [
    id 5
    label "5"
    cpu 21
    gpu 17
    rom 19
  ]
  node [
    id 6
    label "6"
    cpu 5
    gpu 38
    rom 41
  ]
  node [
    id 7
    label "7"
    cpu 45
    gpu 26
    rom 38
  ]
  node [
    id 8
    label "8"
    cpu 48
    gpu 1
    rom 13
  ]
  node [
    id 9
    label "9"
    cpu 20
    gpu 23
    rom 24
  ]
  node [
    id 10
    label "10"
    cpu 6
    gpu 36
    rom 30
  ]
  node [
    id 11
    label "11"
    cpu 43
    gpu 19
    rom 6
  ]
  node [
    id 12
    label "12"
    cpu 19
    gpu 39
    rom 11
  ]
  edge [
    source 0
    target 1
    bw 15
  ]
  edge [
    source 1
    target 2
    bw 4
  ]
  edge [
    source 2
    target 3
    bw 9
  ]
  edge [
    source 3
    target 4
    bw 3
  ]
  edge [
    source 4
    target 5
    bw 24
  ]
  edge [
    source 5
    target 6
    bw 20
  ]
  edge [
    source 6
    target 7
    bw 50
  ]
  edge [
    source 7
    target 8
    bw 42
  ]
  edge [
    source 8
    target 9
    bw 8
  ]
  edge [
    source 9
    target 10
    bw 49
  ]
  edge [
    source 10
    target 11
    bw 35
  ]
  edge [
    source 11
    target 12
    bw 25
  ]
]
