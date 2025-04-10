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
  id 955
  arrival_time 20369.4692959393
  lifetime 823.88311759705
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 50
    gpu 41
    rom 31
  ]
  node [
    id 1
    label "1"
    cpu 47
    gpu 2
    rom 20
  ]
  node [
    id 2
    label "2"
    cpu 26
    gpu 49
    rom 48
  ]
  node [
    id 3
    label "3"
    cpu 48
    gpu 10
    rom 44
  ]
  node [
    id 4
    label "4"
    cpu 43
    gpu 7
    rom 29
  ]
  node [
    id 5
    label "5"
    cpu 33
    gpu 15
    rom 13
  ]
  node [
    id 6
    label "6"
    cpu 8
    gpu 31
    rom 28
  ]
  node [
    id 7
    label "7"
    cpu 16
    gpu 11
    rom 4
  ]
  node [
    id 8
    label "8"
    cpu 32
    gpu 21
    rom 4
  ]
  node [
    id 9
    label "9"
    cpu 26
    gpu 26
    rom 47
  ]
  node [
    id 10
    label "10"
    cpu 23
    gpu 18
    rom 21
  ]
  edge [
    source 0
    target 1
    bw 9
  ]
  edge [
    source 1
    target 2
    bw 49
  ]
  edge [
    source 2
    target 3
    bw 8
  ]
  edge [
    source 3
    target 4
    bw 2
  ]
  edge [
    source 4
    target 5
    bw 50
  ]
  edge [
    source 5
    target 6
    bw 45
  ]
  edge [
    source 6
    target 7
    bw 2
  ]
  edge [
    source 7
    target 8
    bw 0
  ]
  edge [
    source 8
    target 9
    bw 25
  ]
  edge [
    source 9
    target 10
    bw 33
  ]
]
