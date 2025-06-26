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
  id 669
  arrival_time 14293.861000876219
  lifetime 376.32320416511175
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 20
    gpu 20
    rom 37
  ]
  node [
    id 1
    label "1"
    cpu 20
    gpu 8
    rom 9
  ]
  node [
    id 2
    label "2"
    cpu 14
    gpu 34
    rom 30
  ]
  node [
    id 3
    label "3"
    cpu 19
    gpu 6
    rom 1
  ]
  node [
    id 4
    label "4"
    cpu 35
    gpu 17
    rom 45
  ]
  node [
    id 5
    label "5"
    cpu 40
    gpu 2
    rom 38
  ]
  node [
    id 6
    label "6"
    cpu 34
    gpu 6
    rom 2
  ]
  node [
    id 7
    label "7"
    cpu 21
    gpu 0
    rom 13
  ]
  node [
    id 8
    label "8"
    cpu 1
    gpu 27
    rom 6
  ]
  node [
    id 9
    label "9"
    cpu 47
    gpu 50
    rom 19
  ]
  node [
    id 10
    label "10"
    cpu 42
    gpu 13
    rom 31
  ]
  node [
    id 11
    label "11"
    cpu 28
    gpu 13
    rom 16
  ]
  node [
    id 12
    label "12"
    cpu 44
    gpu 3
    rom 41
  ]
  node [
    id 13
    label "13"
    cpu 49
    gpu 29
    rom 15
  ]
  edge [
    source 0
    target 1
    bw 9
  ]
  edge [
    source 1
    target 2
    bw 12
  ]
  edge [
    source 2
    target 3
    bw 1
  ]
  edge [
    source 3
    target 4
    bw 4
  ]
  edge [
    source 4
    target 5
    bw 41
  ]
  edge [
    source 5
    target 6
    bw 36
  ]
  edge [
    source 6
    target 7
    bw 12
  ]
  edge [
    source 7
    target 8
    bw 2
  ]
  edge [
    source 8
    target 9
    bw 40
  ]
  edge [
    source 9
    target 10
    bw 30
  ]
  edge [
    source 10
    target 11
    bw 41
  ]
  edge [
    source 11
    target 12
    bw 12
  ]
  edge [
    source 12
    target 13
    bw 16
  ]
]
