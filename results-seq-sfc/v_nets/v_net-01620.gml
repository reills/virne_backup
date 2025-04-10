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
  id 1620
  arrival_time 36198.831768160155
  lifetime 862.5906983801079
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 35
    gpu 33
    rom 48
  ]
  node [
    id 1
    label "1"
    cpu 10
    gpu 40
    rom 47
  ]
  node [
    id 2
    label "2"
    cpu 32
    gpu 48
    rom 4
  ]
  node [
    id 3
    label "3"
    cpu 39
    gpu 18
    rom 11
  ]
  node [
    id 4
    label "4"
    cpu 47
    gpu 25
    rom 33
  ]
  node [
    id 5
    label "5"
    cpu 0
    gpu 2
    rom 49
  ]
  node [
    id 6
    label "6"
    cpu 38
    gpu 49
    rom 47
  ]
  node [
    id 7
    label "7"
    cpu 16
    gpu 15
    rom 35
  ]
  node [
    id 8
    label "8"
    cpu 39
    gpu 0
    rom 3
  ]
  node [
    id 9
    label "9"
    cpu 32
    gpu 49
    rom 41
  ]
  node [
    id 10
    label "10"
    cpu 43
    gpu 9
    rom 18
  ]
  node [
    id 11
    label "11"
    cpu 33
    gpu 10
    rom 20
  ]
  node [
    id 12
    label "12"
    cpu 34
    gpu 41
    rom 17
  ]
  edge [
    source 0
    target 1
    bw 12
  ]
  edge [
    source 1
    target 2
    bw 20
  ]
  edge [
    source 2
    target 3
    bw 3
  ]
  edge [
    source 3
    target 4
    bw 41
  ]
  edge [
    source 4
    target 5
    bw 14
  ]
  edge [
    source 5
    target 6
    bw 23
  ]
  edge [
    source 6
    target 7
    bw 16
  ]
  edge [
    source 7
    target 8
    bw 47
  ]
  edge [
    source 8
    target 9
    bw 30
  ]
  edge [
    source 9
    target 10
    bw 20
  ]
  edge [
    source 10
    target 11
    bw 50
  ]
  edge [
    source 11
    target 12
    bw 2
  ]
]
