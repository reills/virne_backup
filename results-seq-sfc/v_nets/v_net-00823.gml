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
  id 823
  arrival_time 17066.782522088884
  lifetime 930.6538915343197
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 12
    gpu 50
    rom 40
  ]
  node [
    id 1
    label "1"
    cpu 29
    gpu 21
    rom 22
  ]
  node [
    id 2
    label "2"
    cpu 10
    gpu 19
    rom 15
  ]
  node [
    id 3
    label "3"
    cpu 2
    gpu 19
    rom 18
  ]
  node [
    id 4
    label "4"
    cpu 20
    gpu 17
    rom 9
  ]
  node [
    id 5
    label "5"
    cpu 21
    gpu 22
    rom 17
  ]
  node [
    id 6
    label "6"
    cpu 14
    gpu 19
    rom 39
  ]
  node [
    id 7
    label "7"
    cpu 43
    gpu 47
    rom 0
  ]
  node [
    id 8
    label "8"
    cpu 36
    gpu 33
    rom 7
  ]
  node [
    id 9
    label "9"
    cpu 47
    gpu 22
    rom 8
  ]
  node [
    id 10
    label "10"
    cpu 22
    gpu 36
    rom 35
  ]
  node [
    id 11
    label "11"
    cpu 6
    gpu 32
    rom 43
  ]
  edge [
    source 0
    target 1
    bw 8
  ]
  edge [
    source 1
    target 2
    bw 39
  ]
  edge [
    source 2
    target 3
    bw 25
  ]
  edge [
    source 3
    target 4
    bw 44
  ]
  edge [
    source 4
    target 5
    bw 8
  ]
  edge [
    source 5
    target 6
    bw 10
  ]
  edge [
    source 6
    target 7
    bw 3
  ]
  edge [
    source 7
    target 8
    bw 24
  ]
  edge [
    source 8
    target 9
    bw 30
  ]
  edge [
    source 9
    target 10
    bw 17
  ]
  edge [
    source 10
    target 11
    bw 45
  ]
]
