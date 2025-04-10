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
  id 281
  arrival_time 5394.259900881371
  lifetime 189.78453676743717
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 3
    gpu 18
    rom 45
  ]
  node [
    id 1
    label "1"
    cpu 4
    gpu 24
    rom 35
  ]
  node [
    id 2
    label "2"
    cpu 37
    gpu 35
    rom 24
  ]
  node [
    id 3
    label "3"
    cpu 20
    gpu 39
    rom 47
  ]
  node [
    id 4
    label "4"
    cpu 20
    gpu 2
    rom 7
  ]
  node [
    id 5
    label "5"
    cpu 6
    gpu 22
    rom 22
  ]
  node [
    id 6
    label "6"
    cpu 13
    gpu 6
    rom 39
  ]
  node [
    id 7
    label "7"
    cpu 47
    gpu 30
    rom 9
  ]
  node [
    id 8
    label "8"
    cpu 4
    gpu 11
    rom 24
  ]
  node [
    id 9
    label "9"
    cpu 28
    gpu 29
    rom 3
  ]
  node [
    id 10
    label "10"
    cpu 21
    gpu 34
    rom 34
  ]
  node [
    id 11
    label "11"
    cpu 26
    gpu 50
    rom 26
  ]
  edge [
    source 0
    target 1
    bw 15
  ]
  edge [
    source 1
    target 2
    bw 5
  ]
  edge [
    source 2
    target 3
    bw 27
  ]
  edge [
    source 3
    target 4
    bw 1
  ]
  edge [
    source 4
    target 5
    bw 25
  ]
  edge [
    source 5
    target 6
    bw 28
  ]
  edge [
    source 6
    target 7
    bw 29
  ]
  edge [
    source 7
    target 8
    bw 10
  ]
  edge [
    source 8
    target 9
    bw 7
  ]
  edge [
    source 9
    target 10
    bw 44
  ]
  edge [
    source 10
    target 11
    bw 18
  ]
]
