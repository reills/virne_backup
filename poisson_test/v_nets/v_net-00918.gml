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
  id 918
  arrival_time 19649.229906070745
  lifetime 1423.2080909447416
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 45
    gpu 36
    rom 37
  ]
  node [
    id 1
    label "1"
    cpu 20
    gpu 35
    rom 32
  ]
  node [
    id 2
    label "2"
    cpu 21
    gpu 9
    rom 33
  ]
  node [
    id 3
    label "3"
    cpu 42
    gpu 49
    rom 14
  ]
  node [
    id 4
    label "4"
    cpu 47
    gpu 12
    rom 1
  ]
  node [
    id 5
    label "5"
    cpu 27
    gpu 12
    rom 42
  ]
  node [
    id 6
    label "6"
    cpu 32
    gpu 39
    rom 18
  ]
  node [
    id 7
    label "7"
    cpu 14
    gpu 0
    rom 34
  ]
  node [
    id 8
    label "8"
    cpu 45
    gpu 11
    rom 17
  ]
  node [
    id 9
    label "9"
    cpu 4
    gpu 34
    rom 13
  ]
  node [
    id 10
    label "10"
    cpu 21
    gpu 50
    rom 14
  ]
  node [
    id 11
    label "11"
    cpu 15
    gpu 2
    rom 29
  ]
  edge [
    source 0
    target 1
    bw 23
  ]
  edge [
    source 1
    target 2
    bw 15
  ]
  edge [
    source 2
    target 3
    bw 0
  ]
  edge [
    source 3
    target 4
    bw 22
  ]
  edge [
    source 4
    target 5
    bw 11
  ]
  edge [
    source 5
    target 6
    bw 27
  ]
  edge [
    source 6
    target 7
    bw 13
  ]
  edge [
    source 7
    target 8
    bw 37
  ]
  edge [
    source 8
    target 9
    bw 31
  ]
  edge [
    source 9
    target 10
    bw 21
  ]
  edge [
    source 10
    target 11
    bw 16
  ]
]
