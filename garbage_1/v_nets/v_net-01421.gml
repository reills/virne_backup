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
  id 1421
  arrival_time 29671.05405516244
  lifetime 56.932758170889414
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 20
    gpu 40
    rom 47
  ]
  node [
    id 1
    label "1"
    cpu 27
    gpu 39
    rom 27
  ]
  node [
    id 2
    label "2"
    cpu 3
    gpu 50
    rom 0
  ]
  node [
    id 3
    label "3"
    cpu 50
    gpu 26
    rom 3
  ]
  node [
    id 4
    label "4"
    cpu 18
    gpu 29
    rom 46
  ]
  node [
    id 5
    label "5"
    cpu 41
    gpu 8
    rom 21
  ]
  node [
    id 6
    label "6"
    cpu 3
    gpu 0
    rom 37
  ]
  node [
    id 7
    label "7"
    cpu 19
    gpu 7
    rom 47
  ]
  node [
    id 8
    label "8"
    cpu 19
    gpu 14
    rom 39
  ]
  node [
    id 9
    label "9"
    cpu 45
    gpu 6
    rom 11
  ]
  node [
    id 10
    label "10"
    cpu 44
    gpu 34
    rom 34
  ]
  node [
    id 11
    label "11"
    cpu 13
    gpu 18
    rom 28
  ]
  node [
    id 12
    label "12"
    cpu 41
    gpu 49
    rom 0
  ]
  node [
    id 13
    label "13"
    cpu 31
    gpu 14
    rom 8
  ]
  node [
    id 14
    label "14"
    cpu 42
    gpu 42
    rom 50
  ]
  edge [
    source 0
    target 1
    bw 49
  ]
  edge [
    source 1
    target 2
    bw 47
  ]
  edge [
    source 2
    target 3
    bw 7
  ]
  edge [
    source 3
    target 4
    bw 21
  ]
  edge [
    source 4
    target 5
    bw 16
  ]
  edge [
    source 5
    target 6
    bw 44
  ]
  edge [
    source 6
    target 7
    bw 7
  ]
  edge [
    source 7
    target 8
    bw 22
  ]
  edge [
    source 8
    target 9
    bw 11
  ]
  edge [
    source 9
    target 10
    bw 45
  ]
  edge [
    source 10
    target 11
    bw 26
  ]
  edge [
    source 11
    target 12
    bw 13
  ]
  edge [
    source 12
    target 13
    bw 20
  ]
  edge [
    source 13
    target 14
    bw 2
  ]
]
