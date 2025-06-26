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
  id 1634
  arrival_time 36639.81284737622
  lifetime 3341.2962978825426
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 12
    gpu 44
    rom 10
  ]
  node [
    id 1
    label "1"
    cpu 49
    gpu 24
    rom 46
  ]
  node [
    id 2
    label "2"
    cpu 20
    gpu 12
    rom 14
  ]
  node [
    id 3
    label "3"
    cpu 19
    gpu 34
    rom 12
  ]
  node [
    id 4
    label "4"
    cpu 24
    gpu 36
    rom 29
  ]
  node [
    id 5
    label "5"
    cpu 30
    gpu 39
    rom 8
  ]
  node [
    id 6
    label "6"
    cpu 2
    gpu 38
    rom 27
  ]
  node [
    id 7
    label "7"
    cpu 27
    gpu 33
    rom 23
  ]
  node [
    id 8
    label "8"
    cpu 5
    gpu 50
    rom 48
  ]
  node [
    id 9
    label "9"
    cpu 46
    gpu 34
    rom 11
  ]
  node [
    id 10
    label "10"
    cpu 46
    gpu 19
    rom 24
  ]
  node [
    id 11
    label "11"
    cpu 19
    gpu 32
    rom 22
  ]
  node [
    id 12
    label "12"
    cpu 14
    gpu 7
    rom 37
  ]
  node [
    id 13
    label "13"
    cpu 50
    gpu 38
    rom 30
  ]
  node [
    id 14
    label "14"
    cpu 10
    gpu 22
    rom 3
  ]
  edge [
    source 0
    target 1
    bw 41
  ]
  edge [
    source 1
    target 2
    bw 34
  ]
  edge [
    source 2
    target 3
    bw 20
  ]
  edge [
    source 3
    target 4
    bw 6
  ]
  edge [
    source 4
    target 5
    bw 8
  ]
  edge [
    source 5
    target 6
    bw 15
  ]
  edge [
    source 6
    target 7
    bw 26
  ]
  edge [
    source 7
    target 8
    bw 43
  ]
  edge [
    source 8
    target 9
    bw 32
  ]
  edge [
    source 9
    target 10
    bw 33
  ]
  edge [
    source 10
    target 11
    bw 38
  ]
  edge [
    source 11
    target 12
    bw 17
  ]
  edge [
    source 12
    target 13
    bw 2
  ]
  edge [
    source 13
    target 14
    bw 18
  ]
]
